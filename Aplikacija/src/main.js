const prod = process.env.NODE_ENV === "production";
const shouldSW = "serviceWorker" in navigator && prod;
if (shouldSW) {
    navigator.serviceWorker.register("service-worker").then(() => {
        console.log("Service Worker Registered!");
    });
}
