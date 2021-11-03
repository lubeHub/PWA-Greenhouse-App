(() => {
"use strict";
const Cache = {
    cache_name: "app-cache-v1", //bump this number on every update of your app
    cached: [
       "/"
    ],
    handleInstall(event) {
        event.waitUntil(
            caches.open(this.cache_name).then(
                function(cache) {
                    var x = cache.addAll(this.cached);
                    return x;
                }.bind(this)
            )
        );
    },
    handleFetch(event) {
        if (
            !this.cached.includes(event.request.url)
        ) {
            return;
        }
        event.respondWith(
            caches.match(event.request).then(function(response) {
                if (response) {
                    return response;
                }
                return fetch(event.request);
            })
        );
    },
    clean(){
        let scope = this;
        caches.keys().then(function(names){
            names.forEach(function(name){
                if(name !== scope.cache_name){
                    caches.delete(name)
                }
            })
        }).then(() => self.clients.claim())
    },
    init() {
        self.addEventListener("fetch", this.handleFetch.bind(this));
        self.addEventListener("install", this.handleInstall.bind(this));
    },
};
self.addEventListener("activate", function(event) {
    event.waitUntil(Cache.clean())
});

Cache.init();
})