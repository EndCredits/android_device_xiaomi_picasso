/*
 * Copyright (C) 2019 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <android-base/logging.h>
#include <android-base/properties.h>
#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>
#include <sys/sysinfo.h>

#include "property_service.h"
#include "vendor_init.h"

using android::base::GetProperty;

constexpr const char *RO_PROP_SOURCES[] = {
    nullptr,   "product.", "product_services.", "odm.",
    "vendor.", "system.", "system_ext.", "bootimage.",
};

constexpr const char *PRODUCTS[] = {
    "picasso",
    "picasso_48m",
};

constexpr const char *DEVICES[] = {
    "Redmi K30 5G",
    "Redmi K30i 5G",
};

constexpr const char *BUILD_DESCRIPTION[] = {
    "raven-user 12 SD1A.210817.036 7805805 release-keys",
};

constexpr const char *BUILD_FINGERPRINT[] = {
    "google/raven/raven:12/SD1A.210817.036/7805805:user/"
    "release-keys",
};

constexpr const char *CLIENT_ID[] = {
    "android-xiaomi",
};

void property_override(char const prop[], char const value[])
{
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void load_props(const char *model, bool is_in = false) {
  const auto ro_prop_override = [](const char *source, const char *prop,
                                   const char *value, bool product) {
    std::string prop_name = "ro.";

    if (product)
      prop_name += "product.";
    if (source != nullptr)
      prop_name += source;
    if (!product)
      prop_name += "build.";
    prop_name += prop;

    property_override(prop_name.c_str(), value);
  };

  for (const auto &source : RO_PROP_SOURCES) {
    ro_prop_override(source, "device", is_in ? PRODUCTS[1] : PRODUCTS[0], true);
    ro_prop_override(source, "model", model, true);
    if (!is_in) {
      ro_prop_override(source, "name", PRODUCTS[0], true);
      ro_prop_override(source, "fingerprint", BUILD_FINGERPRINT[0], false);
    } else {
      ro_prop_override(source, "name", PRODUCTS[1], true);
      ro_prop_override(source, "fingerprint", BUILD_FINGERPRINT[0], false);
    }
  }
  ro_prop_override(nullptr, "description", BUILD_DESCRIPTION[0], false);
  ro_prop_override(nullptr, "com.google.clientidbase", CLIENT_ID[0], false);
  ro_prop_override(nullptr, "product", model, false);
}

void load_dalvik_properties() {
    struct sysinfo sys;

    sysinfo(&sys);
    if (sys.totalram < 6144ull * 1024 * 1024) {
        // from - phone-xhdpi-6144-dalvik-heap.mk
        property_override("dalvik.vm.heapstartsize", "16m");
        property_override("dalvik.vm.heapgrowthlimit", "256m");
        property_override("dalvik.vm.heapsize", "512m");
        property_override("dalvik.vm.heapmaxfree", "32m");
    } else {
        // 8GB
        property_override("dalvik.vm.heapstartsize", "32m");
        property_override("dalvik.vm.heapgrowthlimit", "512m");
        property_override("dalvik.vm.heapsize", "768m");
        property_override("dalvik.vm.heapmaxfree", "64m");
    }

    property_override("dalvik.vm.heaptargetutilization", "0.5");
    property_override("dalvik.vm.heapminfree", "8m");
}

void vendor_load_properties() {
    std::string variant = android::base::GetProperty("ro.boot.hwc", "");
    
    if (variant == "picasso") {
    load_props(DEVICES[0], false);
  } else if (variant == "picasso_48m") {
    load_props(DEVICES[1], true);
  }
}
