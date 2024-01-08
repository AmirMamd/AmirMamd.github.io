'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "8b0049402b665cd3871e320e772db045",
"assets/AssetManifest.json": "dc9c079a4faeb48cf8c320feeabb00cf",
"assets/assets/6thOctober.webp": "dc681ce09e059d32c152446575a0a950",
"assets/assets/Abaseya.webp": "2cf49a664eff929fc20f516b13eff847",
"assets/assets/Abdu%2520Basha.jpg": "ad9a72f8061df3c640eb0ec7fa5a18a2",
"assets/assets/AsemaEdareya.jpg": "b22edc1707d695853cbd553fe723b342",
"assets/assets/Attaba.jpg": "4aadcf1f430bcc40a50d163d0625dc0f",
"assets/assets/Badr.webp": "23487abc6c85e9f8b0a07fcc120e7e54",
"assets/assets/bg.png": "d7aefe4a377480eceba9aac4a3663653",
"assets/assets/CairoFestival.jpeg": "0403eb222cdb2396dec781eeba1eff19",
"assets/assets/Card.png": "2c4252905bf68cbcaccf8adaff09a455",
"assets/assets/carpool.png": "970db2e597c780dfea8b509b4773ae2b",
"assets/assets/Driver.jpg": "9a30aede4f046d8621317babca0e6d66",
"assets/assets/DriverWelcome.jpg": "453dc86e44aa725f6772cfcee3482c61",
"assets/assets/ElMohandseen.jpg": "6c7cc09511f836fc667241ee56127009",
"assets/assets/ElNozha.jpg": "71bc278cb84923226a83ed2d2b7c0e2e",
"assets/assets/ElSheikhZayed.jpg": "983efd16f87c457001cecbcc6bf64e8a",
"assets/assets/ElShrouk.webp": "30dd0fe5f057bf5d11f87c8509d113f4",
"assets/assets/Embarrased%2520Monkey.png": "c8976d38b8150765668c81dc9e398b7e",
"assets/assets/FOEASU.jpg": "ab9965a9bb414807364791a44b39a84e",
"assets/assets/FromFaculty.jpeg": "c1e02173760f67cda0b2edacacbf13aa",
"assets/assets/Giza.jpg": "91c63a26938be0014d539ae99d4ac15f",
"assets/assets/Hear%2520No%2520Evil%2520Monkey.webp": "d127b53e6cb5563e61a9e7dae4086cb6",
"assets/assets/LoginCover.png": "54c3efc141a0ce271d036df545cfdf32",
"assets/assets/LoginUncover.png": "41e6c58dca70f4c26c9b71a42478cc44",
"assets/assets/Maadi.jpg": "f7ca9bc6436c8132f8b86c002fb0dd00",
"assets/assets/Madinty.jpg": "a78ce2f3784955d6c6877ee5e9a1e6a3",
"assets/assets/MasrElAdeema.jpg": "9da60f413c9ea01abf2f789db2a59998",
"assets/assets/MasrElGdeeda.jpeg": "18168528de9b90a6e28e284f22a8faed",
"assets/assets/Mastercard.png": "7e386dc6c169e7164bd6f88bffb733c7",
"assets/assets/Mokatam.jpg": "6402f690d7d48cf80d31c63ae8c96454",
"assets/assets/NasrCity.jpg": "af9eee9730d0a0903ce58efdff8e2be2",
"assets/assets/NewCairo.jpg": "36c2f77360c0f50785ebf5fdf2d60af6",
"assets/assets/NewHeliopolis.jpg": "5a46179ee9ccb815db3c42d475f13da6",
"assets/assets/Obour.jpg": "5b1d588a9d5212c0383f479d98637ab8",
"assets/assets/one.png": "2a2af1fb1eb07fe7d77e29a42cbb300d",
"assets/assets/Shobra.jpg": "215b54f31a7b479fe83d9b253905bc0e",
"assets/assets/two.png": "69c749f96213c245c2ac40b17c0d68ed",
"assets/assets/Welcome.png": "773fa0f06a76135035592595f255c13f",
"assets/assets/WelcomeBg.jpg": "f02c81fe6ce67081569723835bf0f28a",
"assets/assets/WestElBalad.jpeg": "19bfb4bdcd485d0f0858205877823efc",
"assets/assets/Zamalek.png": "99e4b589325c4ef942f567314ee8d5f7",
"assets/assets/Zatoon.jpg": "7757364f77eec4c79d93fbcf38042cea",
"assets/FontManifest.json": "d0975c94afeb32ec4155750ce2543f5e",
"assets/fonts/MaterialIcons-Regular.otf": "5b327f9846461383dd8f61db5d09db2f",
"assets/NOTICES": "04f19480fd722076575d8e073452d1db",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/flutter_credit_card/font/halter.ttf": "4e081134892cd40793ffe67fdc3bed4e",
"assets/packages/flutter_credit_card/icons/amex.png": "f75cabd609ccde52dfc6eef7b515c547",
"assets/packages/flutter_credit_card/icons/chip.png": "5728d5ac34dbb1feac78ebfded493d69",
"assets/packages/flutter_credit_card/icons/discover.png": "62ea19837dd4902e0ae26249afe36f94",
"assets/packages/flutter_credit_card/icons/elo.png": "ffd639816704b9f20b73815590c67791",
"assets/packages/flutter_credit_card/icons/hipercard.png": "921660ec64a89da50a7c82e89d56bac9",
"assets/packages/flutter_credit_card/icons/mastercard.png": "7e386dc6c169e7164bd6f88bffb733c7",
"assets/packages/flutter_credit_card/icons/rupay.png": "a10fbeeae8d386ee3623e6160133b8a8",
"assets/packages/flutter_credit_card/icons/unionpay.png": "87176915b4abdb3fcc138d23e4c8a58a",
"assets/packages/flutter_credit_card/icons/visa.png": "f6301ad368219611958eff9bb815abfe",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "b3dececd77f75cce087d515c537181a9",
"/": "b3dececd77f75cce087d515c537181a9",
"main.dart.js": "1563e567b13d7476dda876b025185ffa",
"manifest.json": "84cd3f2e320e96835b8bd6b6ef38784e",
"version.json": "5ceebd784c83e85ce0d8eaa1488708ea"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
