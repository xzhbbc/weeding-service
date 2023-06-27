const Koa = require("koa");
const Router = require("koa-router");
const logger = require("koa-logger");
const bodyParser = require("koa-bodyparser");
const fs = require("fs");
if (fs.existsSync('./.env')) {
  require('./.env')
}
const path = require("path");
const { init: initDB } = require("./db");

const router = new Router();

const homePage = fs.readFileSync(path.join(__dirname, "index.html"), "utf-8");

// 首页
router.get("/", async (ctx) => {
  ctx.body = homePage;
});

const app = new Koa();
app
  .use(logger())
  .use(bodyParser())
  .use(router.routes())
  .use(router.allowedMethods());

const port = process.env.PORT || 80;
async function bootstrap() {
  await initDB();
  fs.readdirSync(path.join(__dirname, './router')).forEach(route => {
      let api = require(`./router/${route}`)
      router.use(`/${route.replace('.js', '')}`, api.routes())
  })
  app.listen(port, () => {
    console.log("启动成功", port);
  });
}
bootstrap();
