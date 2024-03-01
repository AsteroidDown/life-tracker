'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "4ac40019c59b75ec57e872c2fe628c70",
"index.html": "56362287179e824e7ea4b7565fc4d0b2",
"/": "56362287179e824e7ea4b7565fc4d0b2",
"life-tracker-web/.git/config": "f6aaed9871a974bd97e4ac201c7ed86e",
"life-tracker-web/.git/objects/6f/9509c88bed7080d496fc5e1d87a9315e30549d": "c02716d7aaed30ce1c5697a2fb40d317",
"life-tracker-web/.git/objects/3d/44c739c4a5a2d97cd51d9cea80c66273f0573e": "4d1d021b5bf0fdfb01778bb9eff0c137",
"life-tracker-web/.git/objects/df/e0770424b2a19faf507a501ebfc23be8f54e7b": "76f8baefc49c326b504db7bf751c967d",
"life-tracker-web/.git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
"life-tracker-web/.git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
"life-tracker-web/.git/logs/HEAD": "501b61b6af1e75dc95348bc0108854f5",
"life-tracker-web/.git/logs/refs/heads/main": "501b61b6af1e75dc95348bc0108854f5",
"life-tracker-web/.git/logs/refs/remotes/origin/HEAD": "3f1fcf4cd3b81f25abad7e9c4784d70a",
"life-tracker-web/.git/logs/refs/remotes/origin/main": "8d0c546fc0a2f9ca6f10a53db834b8a5",
"life-tracker-web/.git/description": "de2c94c66ec2045cd65f339810d48ecc",
"life-tracker-web/.git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
"life-tracker-web/.git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
"life-tracker-web/.git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
"life-tracker-web/.git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
"life-tracker-web/.git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
"life-tracker-web/.git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
"life-tracker-web/.git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
"life-tracker-web/.git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
"life-tracker-web/.git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
"life-tracker-web/.git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
"life-tracker-web/.git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
"life-tracker-web/.git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
"life-tracker-web/.git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
"life-tracker-web/.git/refs/heads/main": "3ce47329184b070101f16a0bfda6e987",
"life-tracker-web/.git/refs/remotes/origin/HEAD": "98b16e0b650190870f1b40bc8f4aec4e",
"life-tracker-web/.git/refs/remotes/origin/main": "3ce47329184b070101f16a0bfda6e987",
"life-tracker-web/.git/index": "a91030138d7454d2eb1af3598901f563",
"life-tracker-web/.git/COMMIT_EDITMSG": "d778d8b1f42d0dd1bb284e5ca9549187",
"life-tracker-web/.git/FETCH_HEAD": "79cba72267685c7536d3f78e53fa26b6",
"main.dart.js": "b1da007ad66acfce5dd1fc3be248ba5f",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "9bf5841568536740894839875def9bc4",
"assets/AssetManifest.json": "bd8b2abed68707e1b0b6c81ab3e7829c",
"assets/NOTICES": "d3f2873510ebce454dd79ebcb034cee7",
"assets/FontManifest.json": "3ddd9b2ab1c2ae162d46e3cc7b78ba88",
"assets/AssetManifest.bin.json": "b6c749bb5f42221957d66bac7439cd15",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "0ebc4e7ca5e040da671730a59b181135",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "2f141ffd94f3ef0ed716615fd537e708",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "c6ac80bdc5b2896345377c9439f91d54",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "694c81aa4652a35087d55c709f226626",
"assets/fonts/MaterialIcons-Regular.otf": "964f7b66365d8ea71213ca19ee454b25",
"assets/assets/XP.png": "769b91a0ceaf169834112319dce81f7c",
"assets/assets/Energy.png": "9b48839ccb3c8e65bbac1e81e6022f88",
"assets/assets/Colorless.png": "2fa29c5d7bdc98fd9276eb36324a5f7e",
"assets/assets/Blue.png": "61576330a4de58ee4b56092069be10ec",
"assets/assets/d20.png": "2c48196fa7c575da2bdc50af424c71ba",
"assets/assets/d8.png": "00397007685b780f3169705481bf5e51",
"assets/assets/Black.png": "94c233fe9b9161243333eba714f04eba",
"assets/assets/Poison.png": "137f95f920c137ec6d5bdf118d6d9539",
"assets/assets/d6.png": "b4140b3aa8c4142e22572c92b7d33e19",
"assets/assets/Green.png": "ba0fc6b843d539da6a1facabca9ae5a1",
"assets/assets/d4.png": "1082307a8606590747ed2fea1871b456",
"assets/assets/Tax.png": "dcb0ac3f336e34b9d99cec78941c65c0",
"assets/assets/d10.png": "90e40b4f3b961ce772cb7af4f0698893",
"assets/assets/d12.png": "286e1795bab4b7590571bcd56065d257",
"assets/assets/White.png": "71b1d2825dbcc2005c82f57050589150",
"assets/assets/Red.png": "89b0850ca96513c0c0df4fe6b533cd59",
"assets/assets/Storm.png": "a7464ed1e7fdc17db11df915f18dd323",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
