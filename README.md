<div align="center">

# EazyVercel — Multi-Relay XHTTP Installer

### 🌐 Automated VLESS + XHTTP + TLS proxy with multiple Vercel/Netlify relays on a single server with a single domain

**🌐 Language:** [🇮🇷 فارسی](#فارسی) • [🇬🇧 English](#english)

[![Telegram Channel](https://img.shields.io/badge/Channel-@schmitzws-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/schmitzws)
[![Telegram](https://img.shields.io/badge/Contact-@schmi7zz-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/schmi7zz)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-20.04%2B-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](#)
[![Bash](https://img.shields.io/badge/Bash-Script-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](#)
[![License](https://img.shields.io/badge/License-GPL--3.0-yellow?style=for-the-badge)](#)

[![Vercel](https://img.shields.io/badge/Vercel-Supported-000000?style=flat-square&logo=vercel)](#)
[![Netlify](https://img.shields.io/badge/Netlify-Supported-00C7B7?style=flat-square&logo=netlify)](#)
[![Xray](https://img.shields.io/badge/Xray--core-VLESS%2BXHTTP-purple?style=flat-square)](#)

</div>

---

<a name="english"></a>

## English

### What this is

EazyVercel is a personal fork of [avacocloud/XHTTP-Installer](https://github.com/avacocloud/XHTTP-Installer) that adds **multi-relay support** to a single server. The original installer sets up one VLESS + XHTTP + TLS relay per server and rewrites the whole Xray config on every run. This fork lets you run **several independent relays on the same server** — each with its own inbound port, path, UUID, and its own Vercel/Netlify project (and account/token) — without breaking the relays you already have.

### How it works

All client configs connect to the CDN on port `443` (Vercel/Netlify only serve HTTPS there). The difference between relays lives on the server side and in each CDN project:

```
Client ──443──> Vercel subdomain A ──forward──> your-server:2096 ──> Xray inbound A
Client ──443──> Vercel subdomain B ──forward──> your-server:2097 ──> Xray inbound B
```

Each Vercel/Netlify project sets its `TARGET_DOMAIN` to `https://<your-server>:<internal-port>`, and each relay maps to a separate Xray inbound on that internal port. One Xray process, many inbounds, one shared TLS certificate.

### What's different from upstream

- **Additive config**: new relays are merged into the existing Xray config with `jq` instead of overwriting it. Existing relays survive.
- **Timestamped backups + atomic apply**: every change is backed up, validated with `xray -test`, and rolled back automatically if the new config is invalid.
- **Idempotent SSL**: if a valid certificate already exists on disk, issuance is skipped — no stopping Xray to free port 80 for a renewal that isn't needed.
- **Per-relay prompts**: relay tag, internal port (auto-suggests the first free port from 2096), path, UUID, listen mode, and the CDN project/token are collected per relay.
- **Management commands**: `--list` shows all inbounds (tag, port, path, UUID); `--remove <tag>` removes one relay safely, leaving the rest untouched.

### Requirements

- Ubuntu 20.04+ server with root access
- A domain (or subdomain) pointing to your server for the TLS certificate
- A free Vercel and/or Netlify account (one or more — multiple accounts let you spread traffic across separate free-tier quotas)

### Usage

> ⚠️ Always review a script before running it as root. This installer runs with root privileges and configures system services.

```bash
git clone https://github.com/schmi7zz/eazyvercel.git
cd eazyvercel
sudo bash Deploy-Ubuntu.sh
```

Add another relay later by running the script again — it detects the existing setup and adds a new inbound instead of replacing the old one.

```bash
sudo bash Deploy-Ubuntu.sh --list           # show all relays
sudo bash Deploy-Ubuntu.sh --remove relay-b  # remove one relay
```

### Notes & limits

- On Vercel's free (Hobby) plan, traffic is counted twice (client↔Vercel and Vercel↔server). Heavy traffic can pause the account. Keep large downloads / 4K streaming off the proxy, or use Pro. Spreading relays across multiple free accounts helps distribute this quota.
- Only XHTTP works on Vercel/Netlify edge; WebSocket, gRPC, TCP, mKCP, QUIC, and Reality do not (runtime limitations).
- If `*.vercel.app` ever gets blocked on your network, attach a custom domain to the project and point `sni`/`host` at it.

### Ethics & responsible use

This tool exists to help people bypass unjust internet censorship and protect their privacy. Use it only on your own server and your own CDN accounts. You are responsible for complying with the laws and terms of service that apply to you.

### Credits

- Based on [avacocloud/XHTTP-Installer](https://github.com/avacocloud/XHTTP-Installer) by **avaco_cloud**. All credit for the original nod relay goes to them.
- Multi-relay modifications by [@schmi7zz](https://t.me/schmi7zz).
- Built on [Xray-core](https://github.com/XTLS/Xray-core).

### License

Distributed under the **GPL-3.0** license, the same license as the upstream project. See [`LICENSE`](LICENSE).

---

<a name="فارسی"></a>

## فارسی

<div dir="rtl">

### این چیه؟

EazyVercel یک نسخهٔ شخصی (fork) از پروژهٔ [avacocloud/XHTTP-Installer](https://github.com/avacocloud/XHTTP-Installer) است که قابلیت **چند رله روی یک سرور** را اضافه می‌کند. نصب‌کنندهٔ اصلی فقط یک رلهٔ VLESS + XHTTP + TLS روی هر سرور می‌سازد و در هر بار اجرا کل کانفیگ Xray را بازنویسی می‌کند. این نسخه به شما اجازه می‌دهد **چند رلهٔ مستقل روی یک سرور** داشته باشید — هرکدام با پورت داخلی، path، UUID و پروژهٔ Vercel/Netlify (و اکانت/توکن) مخصوص خودش — بدون اینکه رله‌های قبلی خراب شوند.

### چطور کار می‌کند

همهٔ کانفیگ‌های کلاینت روی پورت `443` به CDN وصل می‌شوند (چون Vercel/Netlify فقط روی همین پورت HTTPS سرو می‌کنند). تفاوت رله‌ها در سمت سرور و در هر پروژهٔ CDN است:

</div>

```
کلاینت ──443──> ساب‌دامین Vercel A ──forward──> سرور‌شما:2096 ──> Xray inbound A
کلاینت ──443──> ساب‌دامین Vercel B ──forward──> سرور‌شما:2097 ──> Xray inbound B
```

<div dir="rtl">

هر پروژهٔ Vercel/Netlify متغیر `TARGET_DOMAIN` خود را روی `https://<سرور>:<پورت-داخلی>` تنظیم می‌کند و هر رله به یک inbound جدا در Xray روی همان پورت داخلی نگاشت می‌شود. یک پروسهٔ Xray، چند inbound، یک گواهی TLS مشترک.

### تفاوت‌ها با نسخهٔ اصلی

- **کانفیگ افزودنی**: رله‌های جدید با `jq` به کانفیگ موجود اضافه می‌شوند، نه بازنویسی. رله‌های قبلی سالم می‌مانند.
- **بکاپ زمان‌دار + اعمال اتمیک**: هر تغییر بکاپ می‌گیرد، با `xray -test` اعتبارسنجی می‌شود و در صورت نامعتبر بودن، خودکار rollback می‌شود.
- **SSL هوشمند (idempotent)**: اگر گواهی معتبر از قبل روی دیسک باشد، صدور دوباره انجام نمی‌شود و Xray بی‌جهت برای آزادسازی پورت ۸۰ متوقف نمی‌شود.
- **ورودی‌های جدا برای هر رله**: تگ، پورت داخلی (اولین پورت آزاد از ۲۰۹۶ به بالا را پیشنهاد می‌دهد)، path، UUID، حالت listen و پروژه/توکن CDN برای هر رله جداگانه گرفته می‌شود.
- **دستورهای مدیریتی**: با `--list` همهٔ inbound ها را می‌بینید و با `--remove <tag>` یک رله را امن حذف می‌کنید بدون اینکه به بقیه دست بخورد.

### پیش‌نیازها

- سرور اوبونتو ۲۰.۰۴ به بالا با دسترسی root
- یک دامنه (یا ساب‌دامنه) که به سرورت اشاره کند، برای گواهی TLS
- یک یا چند اکانت رایگان Vercel و/یا Netlify (چند اکانت کمک می‌کند بار ترافیک بین سهمیه‌های رایگان مختلف پخش شود)

### نحوهٔ استفاده

> ⚠️ همیشه قبل از اجرای هر اسکریپتی با دسترسی root، خودت آن را بررسی کن. این نصب‌کننده با دسترسی root اجرا می‌شود و سرویس‌های سیستم را پیکربندی می‌کند.

</div>

```bash
git clone https://github.com/schmi7zz/eazyvercel.git
cd eazyvercel
sudo bash Deploy-Ubuntu.sh
```

<div dir="rtl">

برای افزودن رلهٔ بعدی، دوباره اسکریپت را اجرا کن — خودش نصب موجود را تشخیص می‌دهد و به‌جای جایگزینی، یک inbound جدید اضافه می‌کند.

</div>

```bash
sudo bash Deploy-Ubuntu.sh --list           # نمایش همهٔ رله‌ها
sudo bash Deploy-Ubuntu.sh --remove relay-b  # حذف یک رله
```

<div dir="rtl">

### نکته‌ها و محدودیت‌ها

- در پلن رایگان (Hobby) ورسل، هر بایت ترافیک دو بار شمرده می‌شود (کلاینت↔ورسل و ورسل↔سرور). ترافیک سنگین می‌تواند اکانت را Pause کند. ویدیوی ۴K و دانلودهای حجیم را از پروکسی خارج کن یا Pro بگیر. پخش رله‌ها روی چند اکانت رایگان به توزیع این سهمیه کمک می‌کند.
- روی edge ورسل/نت‌لیفای فقط XHTTP کار می‌کند؛ WebSocket، gRPC، TCP، mKCP، QUIC و Reality کار نمی‌کنند (محدودیت runtime).
- اگر روزی `*.vercel.app` روی شبکه‌ات بلاک شد، یک دامنهٔ شخصی به پروژه وصل کن و `sni`/`host` را روی آن بگذار.

### اخلاق و استفادهٔ مسئولانه

این ابزار برای کمک به دور زدن سانسور ناعادلانهٔ اینترنت و حفاظت از حریم خصوصی ساخته شده است. فقط روی سرور خودت و اکانت‌های CDN خودت استفاده‌اش کن. مسئولیت رعایت قوانین و شرایط سرویسی که به تو مربوط می‌شود، با خودت است.

### اعتبارها

- بر پایهٔ [avacocloud/XHTTP-Installer](https://github.com/avacocloud/XHTTP-Installer) از **avaco_cloud**. تمام اعتبار نودهای اصلی متعلق به ایشان است.
- تغییرات چندرله توسط [@schmi7zz](https://t.me/schmi7zz).
- ساخته‌شده بر پایهٔ [Xray-core](https://github.com/XTLS/Xray-core).

### لایسنس

تحت لایسنس **GPL-3.0** منتشر شده — همان لایسنس پروژهٔ اصلی. فایل [`LICENSE`](LICENSE) را ببین.

</div>

---

<div align="center">

**📢 کانال:** [@schmitzws](https://t.me/schmitzws) • **💬 ارتباط:** [@schmi7zz](https://t.me/schmi7zz)

</div>
