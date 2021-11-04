const { GenerateSW } = require("workbox-webpack-plugin");

module.exports = {
    publicPath: process.env.NODE_ENV === "development" ? "/vuejs-pwa/" : "",

    configureWebpack: {
        plugins: [new GenerateSW()]
    },
    devServer: {
        proxy: 'https://api.thingspeak.com',
    }
};
