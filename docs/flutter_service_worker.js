'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "4ac40019c59b75ec57e872c2fe628c70",
"index.html": "b08062902ab97b9138aec75aa67bf70b",
"/": "b08062902ab97b9138aec75aa67bf70b",
"main.dart.js": "0725a1ef8a68fe7ff5b8dce93e258369",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "9bf5841568536740894839875def9bc4",
".git/config": "a093314808e679527815959d22b8fae0",
".git/objects/50/08ddfcf53c02e82d7eee2e57c38e5672ef89f6": "d18c553584a7393b594e374cfe29b727",
".git/objects/57/71db651c42c79b7822988a709f2043880ccff5": "b74f9743df4cd58851f68c8505f83630",
".git/objects/3b/6a3258d1c22f00e434e0f41cfdbd623761c093": "9f40c2fda5ed72431e9a2010c47ce934",
".git/objects/6f/9cad4c116bc8d72e2497226abb5c05ee64982c": "0d104480d68c1652a53721377a02a882",
".git/objects/9b/2b87c75f9d6c82c53ec29913418feda13968da": "6b4b49371452d8b87ef17cff1aab18cc",
".git/objects/67/e96de0ca952e6fe0cfa15b64340728d5229950": "f594e2e2cacc74310ea28af55b4327af",
".git/objects/0b/b3fea74b55068ae4b4d6e7cdab8fff9030b649": "46aeb6c15289d343bab75e89a7d878bb",
".git/objects/93/7f22fe6d42a347975d7eba30a54710d3b734aa": "6837b34400e5e2e24f3d246ca9968efa",
".git/objects/93/fc410ab0ec4fd905d182c1a177a58f5a4b85dd": "93f77d82ba7edb195a576a93de30b6dc",
".git/objects/94/bfb1463ad8331bfd687bc751b8920b133da744": "fd2d8c0d844b234856b36b93f652048f",
".git/objects/60/684b6ed6e2164661cc53b76e8dedc02365a8d3": "4f816364bc929cc8429b9e61fb02e6a0",
".git/objects/b5/0254288cc6319d153c4af1d64870d95ee2436f": "468a6506934a07c970a4739eae75eedd",
".git/objects/b2/800a9d7527c4a98e0a8505a85cc059818fd2d8": "9a2d15e3b5084d9fb994f8bb8ac14bd8",
".git/objects/ac/e94d893181c9ce4088768290cee316964cb37a": "f293312941d916f25482b4e847b4ca60",
".git/objects/d7/6b6ce14b8912d72f1843cbd8edb3b191a2f8b8": "c660cc5fb8dc261684512d21d1ce64ef",
".git/objects/d0/381156cb213b8827b5bb6703dd8adc365f65bc": "2b0eeeaeecc18b675aac82b46ae5b241",
".git/objects/b4/07167cc0842752f8c826426f6e51080bfc87ae": "fd0e949e7b9a00ffacbbe39d47ff66ec",
".git/objects/a5/74c45d9e325ad3fed2aacc769028595d501431": "6b41dacd6bc3bddee1cd667156567235",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/c7/16cdb912d8c2634e4e05883e1b8124eec06784": "f5439b37ef3277c870d5088ae614d56f",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/c6/fe1f94c1c415d2fc5ae5103f6e03be5d169ec1": "b71c2e44baff29fba96b7eada49e68c9",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/18/9a49cb1c43d248b1d298392c8c0fd898f8b6b3": "a7f34e4d3de621624ac878c4e2b9f7a3",
".git/objects/16/5ce0ddf03a820a38f48cba9aa0c9df9b6e6b79": "71df17c95c3124eada62b59e7dabda78",
".git/objects/45/75bd6e97d653e3c01498db97790fc8c2c25071": "bf2cb8eba08a9c201c99844de110b1e3",
".git/objects/1f/83fcf712e77d31f88393e0b151d1f1fd361e51": "f2adc77e74403d5179dc975f26e0354d",
".git/objects/74/f693f86ad1e8e10433831e740d4c47480ef694": "91eeff5c59eaec35dcbe284106f0811b",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/07/74c17c0fa7a7e87e24a6935830998d92b52c75": "cd62ee54b7ceea7b2a7804e69b1d9134",
".git/objects/38/43e74248a4656135ec16fe7420895ad813fa10": "50982b7bbb146ac8d29aae53e178bc69",
".git/objects/91/e74ba28a87488e5680af5f34ca5f6ed491bab4": "87a0d9b5f907034e2e617e812111c092",
".git/objects/54/0b712a94d9e9e15ede5cd8055b92586a5b9f5e": "5ebeaf8916fa472dd109b3bf6b1e38d3",
".git/objects/98/98e8e7792aa7583bbe1d478ea13d5b01dd9329": "7d60bd074b083f9135396ca960a4aad8",
".git/objects/5e/6fb715a5515f7d29279acdf8829da98d5ef872": "b64eb255a4820a295479e296524ee6ba",
".git/objects/5e/718f3ba07ea92012bebd2aafe445c95a679369": "44150483552a64173c4c6c191c5a6ebe",
".git/objects/99/856846c149c06b504df22156718dd5143b48e1": "e443333b2a29b392d588e4159d9bc228",
".git/objects/64/c3cd48fc9009c760487f307558b6eaf5a7c0b6": "129e53ebf78c57fa2100c8cc6da17ca2",
".git/objects/90/14c75735c74a82c3e2bfe6d24c1b177a048af8": "c244c7f419feca6346ee2c0c4556c247",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/dc/67dd363b44f82d30dc9bd7cf661744278f4dd3": "fedc759dd4ef5de29d7b523f1c03f1a6",
".git/objects/af/742adee0a85dd21ea96cbd84182e30e085d6cf": "aa25b932ec40efacb1efe27e7cf25d82",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b0/1c8229c68dc0505e2af2a55c8400fb29f1ac19": "859f6e9275720e15bb8c3229c8c98f1a",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/e1/321166b62630cc157cf77467b1014cc684d628": "6458dbaa87a2f82d1a097884714f6b35",
".git/objects/e1/8a40df3b1b0eb9a61edd992104cd07bcc43495": "5f88dba8827cc39c5a9edb0b0cbbfe32",
".git/objects/cd/582a88d4a5032236d8d44741e10e2b3c3ba14c": "fa13e219cdc7a8fc59117af9b42d24ce",
".git/objects/cc/043b3efc467247e57d724d4115235c5945fc0b": "115eae9f958a8994b0417f423a7c8429",
".git/objects/e8/2c5850db3a3482d0c954a4dc122c02de555ce7": "d357cd906b3805bf81477f5527cca086",
".git/objects/c5/f4bc2a4da91586f3005813077f0d0aa9040f82": "3191028b787554cee4652f5050144bff",
".git/objects/c5/eaec43b0afea275149d368917b3a5f31b48b7f": "173594d46d36cdcb00d247123d1412eb",
".git/objects/48/a5ad3bcb2853b24bed18ff6e85a7c9e61f94bb": "66f23b2defe4205a811d7eb69e1efdd9",
".git/objects/4a/39079e580dc9be820cba2fae41238c49eaa798": "ada1a19fea32fbb6719120809b9eae60",
".git/objects/23/c68972a539b5ce436487ba08b6f051ce8008db": "e1abe4fe0558e75a455b5cb7a3f465ae",
".git/objects/71/7117947090611c3967f8681ab1ac0f79bca7fc": "ad4e74c0da46020e04043b5cf7f91098",
".git/objects/1c/47109a767e91e994f53fa228f018d7e0d7c4d4": "0c7535cf56b41cd3cd55e20518f316b3",
".git/objects/7f/cb9dcf1a1d94b77061eebc8b5ecb3796f615e4": "8e14f40d7676d7ee67f1480132515b30",
".git/objects/7a/58a85997e98ffbe3334f33a10653b47307603d": "57bb26d0dffeef99c82ebdb8aa347bd9",
".git/objects/14/228cd9ff3502b21f79bb677f7a7f01a9043afe": "477c8091786472d6e99a1121c37c7d3c",
".git/objects/25/f6f466273b801541ae12d3c541b1ef35fd6c20": "b5e4ea82efd4f4fac067175ab9958474",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "403426fb71d9f65bec0a4881070c61bb",
".git/logs/refs/heads/main": "71f40e161f0e11985ee4ee31b3e44a5e",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/main": "d668071b3662a1bd12df2f8063e220d0",
".git/index": "9dc47748eb00a8a27317435a2a245394",
".git/COMMIT_EDITMSG": "c085f9acd3be1296f727b0ea4e7dda0d",
".git/FETCH_HEAD": "d41d8cd98f00b204e9800998ecf8427e",
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
