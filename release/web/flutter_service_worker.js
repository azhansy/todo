'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "c2c2ae4b400c536fe893bc17df885f8e",
"splash/img/light-2x.png": "5a89948092944e150ac0c8bd244b69ef",
"splash/img/dark-4x.png": "c1351b89824e7a71c39cf3e00226c75b",
"splash/img/light-3x.png": "92f99708267cf03add15ac7863342e22",
"splash/img/dark-3x.png": "92f99708267cf03add15ac7863342e22",
"splash/img/light-4x.png": "c1351b89824e7a71c39cf3e00226c75b",
"splash/img/dark-2x.png": "5a89948092944e150ac0c8bd244b69ef",
"splash/img/dark-1x.png": "5c9a1fe54ea6c3aa339e3a014c2a6947",
"splash/img/light-1x.png": "5c9a1fe54ea6c3aa339e3a014c2a6947",
"splash/style.css": "64227ec06c71fef909f75868ada72c30",
"index.html": "e96477862881c66fb1aecc12590d6085",
"/": "e96477862881c66fb1aecc12590d6085",
"main.dart.js": "039bafa83f86d5afd36f9f2a68274c0d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "73c82eb61ac2c2ca7144219d21ba4370",
"assets/AssetManifest.json": "d0b8417773aabe88087f3f8ea1a11877",
"assets/NOTICES": "8e30ec5ec3fbbe9630d9bba64eea0795",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/packages/flutter_update_dialog/assets/update_ic_close.png": "cef2924be0e145da7ab1eba16043decc",
"assets/packages/flutter_update_dialog/assets/update_bg_app_top.png": "55c14a0a8dc55c20f5eb49443c248348",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/assets/images/light-1.png": "6c8ba31eab30d40b5ce914be52ca484e",
"assets/assets/images/logo3x.png": "92f1d2f60700fde32b19707d5ba4e09e",
"assets/assets/images/light-2.png": "82bff49a319cf52b57967f67ead32154",
"assets/assets/images/logologo.png": "3ce6673145474b795d676664f9b2a080",
"assets/assets/images/ic_honor.svg": "c0e1d4383011d4b30ab6ccc033c499bc",
"assets/assets/images/background.png": "97bcdff34666d1b3e9ccbac7b1a58d95",
"assets/assets/images/logo.png": "92f1d2f60700fde32b19707d5ba4e09e",
"assets/assets/images/ic_honor_header.png": "4b6eb405d131ff53f93df50f0fccab0d",
"assets/assets/images/clock.png": "c0091febbdfb94bacb488b00f4521d5a",
"assets/assets/images/logo.svg": "21abacc972f201923a75da98982bd9db",
"assets/assets/images/bg.png": "ab3c96193ffce5097532e1ce2c945eb4"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
