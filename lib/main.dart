import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خلف الجدار',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late final WebViewController _c;

  @override
  void initState() {
    super.initState();
    _c = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..loadHtmlString(_gameHtml, baseUrl: 'https://khalf.local/');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _c.runJavaScript('window.__back && window.__back()');
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: WebViewWidget(controller: _c),
      ),
    );
  }
}

// ===== كود اللعبة (HTML5) =====
const String _gameHtml = r'''<!doctype html>
<html lang="ar" dir="rtl">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
<meta name="theme-color" content="#050609">
<meta name="mobile-web-app-capable" content="yes">
<title>خلف الجدار</title>
<style>
:root{--gold:#c9a45c;--ink:#e8dcc0;--bg:#050609;--red:#a01820;--panel:rgba(8,9,13,.93);--ts:1}
*{box-sizing:border-box;-webkit-tap-highlight-color:transparent;-webkit-touch-callout:none;user-select:none}
html,body{margin:0;height:100%;background:#000;overflow:hidden;color:var(--ink);font-family:"Noto Naskh Arabic","Amiri","Segoe UI",Tahoma,sans-serif;touch-action:none;overscroll-behavior:none}
#app{position:fixed;inset:0;display:flex;align-items:center;justify-content:center;background:#000}
#cv{display:block;background:#000;image-rendering:auto}
#scr{position:fixed;inset:0;display:none;align-items:center;justify-content:center;background:radial-gradient(ellipse at center,rgba(5,6,9,.55),rgba(0,0,0,.92));z-index:20;overflow:auto;padding:12px}
#scr.on{display:flex}
#scr.center{align-items:center;justify-content:center}
.logo{font-size:clamp(40px,12vh,96px);margin:0;letter-spacing:.04em;color:var(--ink);font-weight:700;text-shadow:0 0 30px rgba(201,164,92,.35),0 0 4px #000;animation:flick 6s infinite}
.logo.sm{font-size:clamp(34px,10vh,72px)}
@keyframes flick{0%,92%,100%{opacity:1}93%{opacity:.55}94%{opacity:1}96%{opacity:.7}97%{opacity:1}}
.tag{color:rgba(232,220,192,.6);margin:6px 0 18px;font-size:clamp(12px,2.4vh,17px)}
.splash{text-align:center}
.splash.intro p{opacity:0;font-size:clamp(22px,6vh,40px);margin:8px;animation:fadeIn 1.6s forwards}
.splash.intro .i2{animation-delay:1.6s;color:#c0584a}
@keyframes fadeIn{to{opacity:1}}
.menu{display:flex;flex-direction:column;align-items:center;max-height:100%}
.mlist{display:flex;flex-direction:column;gap:8px;width:min(420px,88vw)}
.mbtn{display:flex;flex-direction:column;align-items:center;justify-content:center;background:rgba(18,19,26,.85);color:var(--ink);border:1px solid rgba(201,164,92,.35);padding:clamp(7px,1.6vh,13px) 18px;font:inherit;font-size:clamp(14px,3vh,20px);cursor:pointer;transition:.15s;min-height:40px;border-radius:3px}
.mbtn small{font-size:.62em;color:rgba(232,220,192,.55);margin-top:2px;text-align:center}
.mbtn:hover,.mbtn:active{background:rgba(60,48,26,.9);border-color:var(--gold);box-shadow:0 0 18px rgba(201,164,92,.25)}
.mbtn.gold{border-color:var(--gold);background:rgba(70,54,24,.85)}
.mbtn.big{font-size:clamp(18px,4vh,28px);padding:14px 40px}
.mbtn.sm{padding:5px 14px;font-size:clamp(12px,2.4vh,16px);min-height:32px}
.mbtn.danger{border-color:#7a2a2a;color:#e0a0a0}
.mbtn:disabled{opacity:.4}
.ver{margin-top:14px;color:rgba(232,220,192,.4);font-size:clamp(11px,2vh,14px)}
.panel{background:var(--panel);border:1px solid rgba(201,164,92,.3);padding:clamp(10px,2.4vh,22px) clamp(12px,3vw,26px);width:min(520px,94vw);max-height:96vh;min-height:0;display:flex;flex-direction:column;gap:10px;box-shadow:0 0 60px #000}
.panel.wide{width:min(760px,96vw)}
.panel h2{margin:0;text-align:center;font-size:clamp(20px,4.4vh,30px);color:var(--gold)}
.panel h2.red{color:#c0443a}
.panel h3{margin:10px 0 4px;color:var(--gold);font-size:clamp(14px,2.8vh,19px)}
.panel .txt{font-size:clamp(13px,2.6vh,17px);line-height:1.7;color:rgba(232,220,192,.88)}
.panel .txt p{margin:6px 0}
.dim{color:rgba(232,220,192,.55);font-size:clamp(12px,2.3vh,15px);margin:0}
.warn{color:#e08a7a;margin:4px 0;font-size:clamp(12px,2.3vh,15px);min-height:1em}
.row{display:flex;gap:8px;justify-content:center}
.row.wrap{flex-wrap:wrap}
.scroll{overflow:auto;flex:1 1 auto;min-height:0;max-height:70vh;padding:2px 4px;-webkit-overflow-scrolling:touch}
#scr,#scr *{touch-action:pan-y}
#scr textarea,#scr input{touch-action:auto}
#scr .scroll,#scr .panel{overscroll-behavior:contain}
.diffs{display:grid;grid-template-columns:repeat(auto-fit,minmax(130px,1fr));gap:8px}
.diff{border:1px solid rgba(255,255,255,.12);padding:8px 10px;background:rgba(20,21,28,.8);cursor:pointer;border-top:3px solid var(--c)}
.diff b{color:var(--c);font-size:clamp(14px,3vh,19px)}
.diff p{margin:4px 0 0;font-size:clamp(11px,2.2vh,14px);color:rgba(232,220,192,.7);line-height:1.5}
.diff.sel{background:rgba(50,42,28,.95);box-shadow:0 0 0 1px var(--c),0 0 20px -4px var(--c)}
.tabs{display:flex;gap:6px;justify-content:center;flex-wrap:wrap}
.tab{background:none;border:0;border-bottom:2px solid transparent;color:rgba(232,220,192,.6);font:inherit;font-size:clamp(14px,3vh,18px);padding:4px 12px;cursor:pointer}
.tab.sel{color:var(--gold);border-color:var(--gold)}
.lore{border-right:2px solid rgba(201,164,92,.4);padding:2px 10px;margin:8px 0}
.lore h3{margin:0 0 2px}
.lore p{margin:0;font-size:clamp(12px,2.4vh,16px);line-height:1.7}
.set{display:flex;align-items:center;gap:10px;margin:7px 0;font-size:clamp(13px,2.6vh,17px)}
.set>span{flex:1}
.set em{font-style:normal;min-width:44px;text-align:left;color:var(--gold);font-size:.85em}
.set input[type=range]{flex:1.4;accent-color:var(--gold)}
.set input[type=checkbox]{width:22px;height:22px;accent-color:var(--gold)}
.set.col{flex-direction:column;align-items:stretch;gap:3px}
.set input:not([type=range]):not([type=checkbox]):not([type=color]),.set select,textarea{background:#0e0f14;color:var(--ink);border:1px solid rgba(201,164,92,.3);padding:6px 8px;font:inherit;font-size:.9em;user-select:text;border-radius:2px}
.set input[type=color]{width:100%;height:32px;background:none;border:1px solid rgba(201,164,92,.3)}
.grid2{display:grid;grid-template-columns:repeat(auto-fit,minmax(120px,1fr));gap:8px}
textarea{width:100%;resize:vertical;user-select:text}
textarea.code{min-height:36vh;font-family:Consolas,monospace;direction:ltr;text-align:left;font-size:12px}
.mod{border:1px solid rgba(255,255,255,.12);padding:8px 10px;margin:6px 0;background:rgba(18,19,26,.8)}
.mod.on{border-color:var(--gold);box-shadow:0 0 14px -6px var(--gold)}
.mod .mh{display:flex;justify-content:space-between;align-items:baseline;gap:8px}
.mod .mh small{color:rgba(232,220,192,.5)}
.mod p{margin:4px 0;font-size:clamp(12px,2.3vh,15px);color:rgba(232,220,192,.75)}
.mod .mt span{display:inline-block;background:rgba(201,164,92,.15);padding:1px 8px;margin:0 0 6px 6px;font-size:12px;border-radius:2px}
#dlg{position:fixed;left:50%;bottom:clamp(8px,3vh,24px);transform:translateX(-50%);width:min(860px,94vw);background:linear-gradient(180deg,rgba(6,7,10,.9),rgba(3,3,5,.96));border:1px solid rgba(201,164,92,.35);padding:12px 18px 14px;z-index:15;display:none;cursor:pointer;box-shadow:0 0 50px #000}
#dlg.on{display:block}
#dlg.narr #dlg-text{font-style:italic;color:#c8d0dc}
#dlg.boss{border-color:#8a1c24}
#dlg.boss #dlg-name{color:#e07070}
#dlg-name{color:var(--gold);font-weight:700;font-size:clamp(14px,3vh,19px);margin-bottom:3px}
#dlg-text{font-size:clamp(14px,3.1vh,20px);line-height:1.85;min-height:2.6em;color:var(--ink);white-space:pre-wrap}
#dlg-choices{display:flex;flex-direction:column;gap:6px;margin-top:8px}
.choice{text-align:right;background:rgba(24,25,33,.9);color:var(--ink);border:1px solid rgba(201,164,92,.3);padding:7px 12px;font:inherit;font-size:clamp(13px,2.8vh,18px);cursor:pointer;border-radius:2px}
.choice small{color:#e08a7a}
.choice.sel,.choice:hover{border-color:var(--gold);background:rgba(70,54,24,.9)}
.choice:disabled{opacity:.4}
#dlg-next{text-align:left;color:var(--gold);animation:bob 1s infinite;font-size:14px}
@keyframes bob{50%{transform:translateY(3px)}}
#lore{position:fixed;inset:0;display:none;align-items:center;justify-content:center;z-index:18;background:rgba(0,0,0,.6)}
#lore.on{display:flex}
.paper{background:#cdbf9a;color:#2a2113;width:min(560px,90vw);padding:22px 26px;box-shadow:0 0 50px #000;transform:rotate(-.6deg);font-size:clamp(14px,3vh,19px);line-height:1.9;background-image:radial-gradient(rgba(0,0,0,.08) 1px,transparent 1px);background-size:6px 6px}
.paper h3{margin:0 0 6px;color:#4a2a14}
.paper p{margin:0}
.paper .hint{margin-top:10px;font-size:.7em;color:rgba(0,0,0,.45);text-align:center}
#cards{position:fixed;inset:0;background:#000;display:none;align-items:center;justify-content:center;z-index:30;padding:6vw;text-align:center}
#cards.on{display:flex}
#cardtxt{font-size:clamp(20px,5.4vh,38px);line-height:1.9;max-width:900px;opacity:0;margin:0;color:var(--ink);text-shadow:0 0 22px rgba(201,164,92,.25)}
#cardtxt.show{animation:cardin 5s forwards}
@keyframes cardin{0%{opacity:0;filter:blur(8px)}12%{opacity:1;filter:blur(0)}88%{opacity:1}100%{opacity:.0}}
#cards .hint{position:absolute;bottom:14px;color:rgba(232,220,192,.3);font-size:13px}
#banner{position:fixed;left:0;right:0;top:34%;text-align:center;z-index:16;pointer-events:none;opacity:0;transition:opacity .8s}
#banner.on{opacity:1}
#banner h2{margin:0;font-size:clamp(28px,8vh,60px);color:var(--ink);text-shadow:0 0 24px #000,0 0 40px rgba(160,24,32,.6);letter-spacing:.04em}
#banner p{margin:4px 0 0;font-size:clamp(14px,3vh,22px);color:rgba(232,220,192,.75)}
#toast{position:fixed;top:14%;left:50%;transform:translateX(-50%);z-index:17;display:flex;flex-direction:column;gap:6px;align-items:center;pointer-events:none}
.toast{background:rgba(6,7,10,.88);border:1px solid rgba(201,164,92,.4);padding:6px 16px;font-size:clamp(13px,2.8vh,17px);animation:tin .3s;transition:opacity .6s}
.toast.out{opacity:0}
@keyframes tin{from{opacity:0;transform:translateY(-8px)}}
/* لمس */
#touch{position:fixed;inset:0;z-index:12;pointer-events:none;display:none}
#touch.on{display:block}
#touch .pad{position:absolute;bottom:max(12px,env(safe-area-inset-bottom));pointer-events:none}
#touch .pad.l{left:max(14px,env(safe-area-inset-left));width:calc(220px*var(--ts));height:calc(150px*var(--ts))}
#touch .pad.r{right:max(14px,env(safe-area-inset-right));width:calc(260px*var(--ts));height:calc(180px*var(--ts))}
.tb{position:absolute;pointer-events:auto;border-radius:50%;border:2px solid rgba(232,220,192,.45);background:rgba(10,11,16,.55);color:var(--ink);font-size:calc(22px*var(--ts));display:flex;align-items:center;justify-content:center;touch-action:none;width:calc(64px*var(--ts));height:calc(64px*var(--ts));padding:0}
.tb.p{background:rgba(201,164,92,.45);border-color:var(--gold);transform:scale(.94)}
.tb.big{width:calc(84px*var(--ts));height:calc(84px*var(--ts));font-size:calc(32px*var(--ts))}
.tb.sm{width:calc(44px*var(--ts));height:calc(44px*var(--ts));font-size:calc(16px*var(--ts))}
.pad.l .dir:nth-child(1){left:0;bottom:calc(8px*var(--ts));width:calc(84px*var(--ts));height:calc(84px*var(--ts))}
.pad.l .dir:nth-child(2){left:calc(100px*var(--ts));bottom:calc(8px*var(--ts));width:calc(84px*var(--ts));height:calc(84px*var(--ts))}
.pad.l .up{left:calc(50px*var(--ts));bottom:calc(98px*var(--ts))}
.pad.l .dn{left:calc(106px*var(--ts));bottom:calc(98px*var(--ts))}
.pad.r .atk{right:calc(8px*var(--ts));bottom:calc(8px*var(--ts))}
.pad.r .jmp{right:calc(100px*var(--ts));bottom:calc(30px*var(--ts))}
.pad.r .dsh{right:calc(190px*var(--ts));bottom:calc(6px*var(--ts));width:calc(56px*var(--ts));height:calc(56px*var(--ts))}
.pad.r .fcs{right:calc(8px*var(--ts));bottom:calc(104px*var(--ts));width:calc(54px*var(--ts));height:calc(54px*var(--ts))}
.pad.r .vis{right:calc(72px*var(--ts));bottom:calc(120px*var(--ts));width:calc(54px*var(--ts));height:calc(54px*var(--ts))}
.pad.r .act{right:calc(136px*var(--ts));bottom:calc(104px*var(--ts));width:calc(50px*var(--ts));height:calc(50px*var(--ts));font-size:calc(18px*var(--ts))}
#touch .pse{top:max(10px,env(safe-area-inset-top));left:50%;transform:translateX(-50%)}
@media (max-height:420px){.panel{gap:6px}.mlist{gap:5px}}

</style>
</head>
<body>
<div id="app">
  <canvas id="cv"></canvas>
  <div id="scr"></div>
  <div id="dlg">
    <div id="dlg-name"></div>
    <div id="dlg-text"></div>
    <div id="dlg-choices"></div>
    <div id="dlg-next">▼</div>
  </div>
  <div id="lore"></div>
  <div id="cards"></div>
  <div id="banner"></div>
  <div id="toast"></div>
  <div id="touch">
    <div class="pad l">
      <button data-a="left" class="tb dir" aria-label="يسار">◀</button>
      <button data-a="right" class="tb dir" aria-label="يمين">▶</button>
      <button data-a="up" class="tb sm up" aria-label="أعلى">▲</button>
      <button data-a="down" class="tb sm dn" aria-label="أسفل">▼</button>
    </div>
    <div class="pad r">
      <button data-a="attack" class="tb big atk" aria-label="ضرب">⚔</button>
      <button data-a="jump" class="tb big jmp" aria-label="قفز">⤒</button>
      <button data-a="dash" class="tb dsh" aria-label="اندفاع">»</button>
      <button data-a="focus" class="tb fcs" aria-label="شفاء">✚</button>
      <button data-a="vision" class="tb vis" aria-label="رؤية">👁</button>
      <button data-a="interact" class="tb act" aria-label="تفاعل">E</button>
    </div>
    <button data-a="pause" class="tb sm pse" aria-label="إيقاف">II</button>
  </div>
</div>
<script>
'use strict';
/* ===== أدوات عامة ===== */
const VW = 960, VH = 544, TS = 32;
const clamp = (v, a, b) => v < a ? a : v > b ? b : v;
const lerp = (a, b, t) => a + (b - a) * t;
const rnd = (a, b) => b === undefined ? Math.random() * a : a + Math.random() * (b - a);
const rndi = (a, b) => Math.floor(rnd(a, b + 1));
const pick = arr => arr[Math.floor(Math.random() * arr.length)];
const sgn = v => v < 0 ? -1 : v > 0 ? 1 : 0;
const approach = (v, t, d) => v < t ? Math.min(v + d, t) : Math.max(v - d, t);
const overlap = (a, b) => a.x < b.x + b.w && a.x + a.w > b.x && a.y < b.y + b.h && a.y + a.h > b.y;
const $ = id => document.getElementById(id);
function mulberry32(a) {
  return function () {
    a |= 0; a = a + 0x6D2B79F5 | 0;
    let t = Math.imul(a ^ a >>> 15, 1 | a);
    t = t + Math.imul(t ^ t >>> 7, 61 | t) ^ t;
    return ((t ^ t >>> 14) >>> 0) / 4294967296;
  };
}
const Store = {
  get(k, d) { try { const v = localStorage.getItem(k); return v === null ? d : JSON.parse(v); } catch (e) { return d; } },
  set(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); return true; } catch (e) { return false; } },
  del(k) { try { localStorage.removeItem(k); } catch (e) { } }
};
function fmtTime(sec) {
  sec = Math.floor(sec); const h = Math.floor(sec / 3600), m = Math.floor(sec % 3600 / 60);
  return (h ? h + ' س ' : '') + m + ' د';
}
function esc(s) { return String(s).replace(/[&<>"']/g, c => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c])); }

</script>
<script>
'use strict';
/* ===== محرك الصوت: كل الأصوات مولّدة برمجياً (لا ملفات خارجية) =====
   - همسات في الظلام (ضجيج مفلتر بصيغ نطقية + بوابة مقطعية + صدى)
   - أجواء (طنين منخفض + ريح + نغمة نشاز عند التوتر)
   - موسيقى تتبدل: استكشاف / قتال / زعيم
   - مؤثرات قتال ودم
   - أصوات خاصة لكل شخصية */
const Sound = (function () {
  let ctx = null, ready = false, noiseBuf = null, convolver = null;
  const bus = {};
  const vol = { master: .8, music: .6, sfx: .8, voice: .8, amb: .8 };
  let horror = 2;
  let amb = null;
  let mode = 'none', nextT = 0, step = 0, lastMode = 'none';
  const lastPlay = {};

  function makeImpulse(sec, decay) {
    const rate = ctx.sampleRate, len = Math.floor(rate * sec);
    const buf = ctx.createBuffer(2, len, rate);
    for (let c = 0; c < 2; c++) {
      const d = buf.getChannelData(c);
      for (let i = 0; i < len; i++) d[i] = (Math.random() * 2 - 1) * Math.pow(1 - i / len, decay);
    }
    return buf;
  }
  function init() {
    if (ready) { if (ctx.state === 'suspended') ctx.resume(); return true; }
    try {
      const AC = window.AudioContext || window.webkitAudioContext;
      if (!AC) return false;
      ctx = new AC();
      const comp = ctx.createDynamicsCompressor();
      comp.threshold.value = -14; comp.ratio.value = 6;
      bus.master = ctx.createGain();
      bus.master.connect(comp); comp.connect(ctx.destination);
      ['music', 'sfx', 'voice', 'amb'].forEach(k => { bus[k] = ctx.createGain(); bus[k].connect(bus.master); });
      convolver = ctx.createConvolver();
      convolver.buffer = makeImpulse(2.8, 2.4);
      bus.rev = ctx.createGain(); bus.rev.gain.value = .55;
      convolver.connect(bus.rev); bus.rev.connect(bus.master);
      const nl = ctx.sampleRate * 2;
      noiseBuf = ctx.createBuffer(1, nl, ctx.sampleRate);
      const nd = noiseBuf.getChannelData(0);
      for (let i = 0; i < nl; i++) nd[i] = Math.random() * 2 - 1;
      ready = true;
      applyVol();
      startAmbient();
      setInterval(musicTick, 80);
      return true;
    } catch (e) { console.warn('audio init failed', e); return false; }
  }
  function applyVol() {
    if (!ready) return;
    bus.master.gain.value = vol.master;
    bus.music.gain.value = vol.music * 1.0;
    bus.sfx.gain.value = vol.sfx * 2.3;
    bus.voice.gain.value = vol.voice * 2.2;
    bus.amb.gain.value = vol.amb * 1.3;
  }
  function setVolumes(v) { Object.assign(vol, v); applyVol(); }
  function setHorror(h) { horror = h; }

  function panner(p) {
    if (!ctx.createStereoPanner) return null;
    const n = ctx.createStereoPanner(); n.pan.value = clamp(p || 0, -1, 1); return n;
  }
  function route(node, o) {
    let out = node;
    const p = o.pan ? panner(o.pan) : null;
    if (p) { out.connect(p); out = p; }
    out.connect(bus[o.bus || 'sfx']);
    if (o.rev) { const r = ctx.createGain(); r.gain.value = o.rev; out.connect(r); r.connect(convolver); }
  }
  function tone(o) {
    if (!ready) return;
    const t = ctx.currentTime + (o.delay || 0);
    const osc = ctx.createOscillator(), g = ctx.createGain();
    osc.type = o.type || 'sine';
    osc.frequency.setValueAtTime(o.f, t);
    if (o.f2) osc.frequency.exponentialRampToValueAtTime(Math.max(1, o.f2), t + o.dur);
    if (o.detune) osc.detune.value = o.detune;
    const v = o.vol === undefined ? .3 : o.vol;
    g.gain.setValueAtTime(.0001, t);
    g.gain.linearRampToValueAtTime(v, t + (o.a || .004));
    g.gain.exponentialRampToValueAtTime(.0001, t + o.dur);
    osc.connect(g);
    let out = g;
    if (o.lp) { const f = ctx.createBiquadFilter(); f.type = 'lowpass'; f.frequency.value = o.lp; g.connect(f); out = f; }
    route(out, o);
    osc.start(t); osc.stop(t + o.dur + .05);
  }
  function noise(o) {
    if (!ready) return;
    const t = ctx.currentTime + (o.delay || 0);
    const src = ctx.createBufferSource(); src.buffer = noiseBuf; src.loop = true;
    src.playbackRate.value = o.rate || 1;
    const f = ctx.createBiquadFilter(); f.type = o.ft || 'bandpass';
    f.frequency.setValueAtTime(o.f || 1000, t);
    if (o.f2) f.frequency.exponentialRampToValueAtTime(Math.max(20, o.f2), t + o.dur);
    f.Q.value = o.q || 1;
    const g = ctx.createGain();
    const v = o.vol === undefined ? .3 : o.vol;
    g.gain.setValueAtTime(.0001, t);
    g.gain.linearRampToValueAtTime(v, t + (o.a || .003));
    g.gain.exponentialRampToValueAtTime(.0001, t + o.dur);
    src.connect(f); f.connect(g);
    route(g, o);
    src.start(t, Math.random() * 1.5); src.stop(t + o.dur + .05);
  }
  function limited(name, gap) {
    const n = performance.now();
    if (lastPlay[name] && n - lastPlay[name] < gap) return false;
    lastPlay[name] = n; return true;
  }

  const FX = {
    uiClick() { tone({ f: 520, f2: 380, dur: .08, type: 'triangle', vol: .12, lp: 2000 }); },
    uiSelect() { tone({ f: 300, f2: 180, dur: .22, type: 'sine', vol: .25, rev: .4 }); noise({ f: 800, dur: .15, vol: .06, q: 2 }); },
    jump() { noise({ ft: 'highpass', f: 900, f2: 2400, dur: .1, vol: .05 }); tone({ f: 180, f2: 300, dur: .09, type: 'sine', vol: .06 }); },
    land(p) { tone({ f: 90, f2: 50, dur: .12, type: 'sine', vol: .2 * (p || 1) }); noise({ ft: 'lowpass', f: 600, dur: .1, vol: .1 * (p || 1) }); },
    dash() { noise({ ft: 'bandpass', f: 600, f2: 3000, q: .8, dur: .2, vol: .2 }); },
    slash() { noise({ ft: 'bandpass', f: 1200, f2: 4200, q: .9, dur: .14, vol: .22, pan: 0 }); tone({ f: 420, f2: 160, dur: .1, type: 'sawtooth', vol: .04, lp: 1500 }); },
    hit() {
      noise({ ft: 'lowpass', f: 1800, f2: 200, dur: .16, vol: .35 });
      tone({ f: 140, f2: 55, dur: .16, type: 'square', vol: .18, lp: 900 });
      noise({ ft: 'bandpass', f: 400, q: 3, dur: .22, vol: .12, delay: .02 });
    },
    hitHeavy() {
      noise({ ft: 'lowpass', f: 900, f2: 90, dur: .4, vol: .5 });
      tone({ f: 90, f2: 30, dur: .4, type: 'sawtooth', vol: .3, lp: 500 });
      noise({ ft: 'bandpass', f: 300, q: 2, dur: .3, vol: .2, delay: .05 });
    },
    clink() { tone({ f: 2100, dur: .25, type: 'triangle', vol: .12, rev: .5 }); tone({ f: 3300, dur: .18, type: 'sine', vol: .06, rev: .4 }); noise({ ft: 'highpass', f: 3000, dur: .06, vol: .1 }); },
    hurt() {
      tone({ f: 220, f2: 70, dur: .38, type: 'sawtooth', vol: .22, lp: 900 });
      noise({ ft: 'lowpass', f: 1200, f2: 150, dur: .3, vol: .3 });
      tone({ f: 60, f2: 40, dur: .5, type: 'sine', vol: .3, delay: .03 });
    },
    blood() { noise({ ft: 'bandpass', f: 500, f2: 150, q: 4, dur: .22, vol: .18 }); noise({ ft: 'highpass', f: 2000, dur: .05, vol: .1, delay: .02 }); },
    enemyDie() { tone({ f: 260, f2: 40, dur: .5, type: 'sawtooth', vol: .2, lp: 700, rev: .3 }); noise({ ft: 'lowpass', f: 1500, f2: 100, dur: .5, vol: .3 }); },
    pickup() { tone({ f: 880, dur: .16, type: 'sine', vol: .08, rev: .3 }); tone({ f: 1320, dur: .22, type: 'sine', vol: .06, delay: .05, rev: .3 }); },
    ash() { if (!limited('ash', 60)) return; tone({ f: 1000 + Math.random() * 300, dur: .08, type: 'sine', vol: .05 }); },
    heal() { for (let i = 0; i < 4; i++) tone({ f: 330 * Math.pow(1.5, i % 3) * (i > 2 ? 2 : 1), dur: .6, type: 'sine', vol: .09, delay: i * .09, rev: .7 }); },
    shrine() { [220, 330, 440, 660].forEach((f, i) => tone({ f, dur: 2.2, type: 'sine', vol: .1, delay: i * .12, rev: .9 })); noise({ ft: 'highpass', f: 5000, dur: .4, vol: .04 }); },
    vision(on) { if (on) { tone({ f: 80, f2: 200, dur: .5, type: 'sine', vol: .3, rev: .8 }); noise({ f: 300, f2: 3000, q: 2, dur: .5, vol: .1 }); } else { tone({ f: 220, f2: 60, dur: .4, type: 'sine', vol: .25, rev: .6 }); } },
    soulShot() { tone({ f: 500, f2: 900, dur: .3, type: 'sine', vol: .2, rev: .6 }); noise({ f: 2000, f2: 600, dur: .25, vol: .1 }); },
    eyeCharge() { tone({ f: 300, f2: 700, dur: .5, type: 'sine', vol: .1, rev: .5 }); },
    eyeShoot() { tone({ f: 900, f2: 200, dur: .25, type: 'sawtooth', vol: .1, lp: 1500, rev: .4 }); },
    tele() { noise({ ft: 'bandpass', f: 200, f2: 2500, q: 1.2, dur: .45, vol: .18, rev: .5 }); tone({ f: 70, f2: 35, dur: .6, type: 'sine', vol: .25 }); },
    slam() { tone({ f: 70, f2: 25, dur: .7, type: 'sine', vol: .6 }); noise({ ft: 'lowpass', f: 700, f2: 60, dur: .6, vol: .5 }); noise({ f: 200, q: 1, dur: .3, vol: .3, delay: .04 }); },
    roar() {
      tone({ f: 85, f2: 45, dur: 1.4, type: 'sawtooth', vol: .35, lp: 600, rev: .6 });
      tone({ f: 130, f2: 70, dur: 1.2, type: 'square', vol: .12, lp: 500, delay: .05, detune: 30 });
      noise({ ft: 'bandpass', f: 400, f2: 900, q: 1.5, dur: 1.3, vol: .3, rev: .5 });
    },
    scream() {
      tone({ f: 900, f2: 1500, dur: .9, type: 'sawtooth', vol: .09, lp: 3000, rev: .8 });
      tone({ f: 940, f2: 1440, dur: .9, type: 'sawtooth', vol: .09, lp: 3000, rev: .8, detune: 25 });
      noise({ ft: 'bandpass', f: 2500, q: 3, dur: .8, vol: .1, rev: .6 });
    },
    chain() { for (let i = 0; i < 5; i++) tone({ f: 1800 + Math.random() * 1500, dur: .05, type: 'square', vol: .05, delay: i * .035, lp: 4000 }); },
    spike() { tone({ f: 120, f2: 40, dur: .25, type: 'sawtooth', vol: .25, lp: 700 }); noise({ ft: 'highpass', f: 1500, dur: .1, vol: .2 }); },
    break() { noise({ ft: 'lowpass', f: 2500, f2: 150, dur: .5, vol: .5 }); tone({ f: 80, f2: 30, dur: .4, type: 'sine', vol: .4 }); },
    secret() { [523, 659, 784, 1047].forEach((f, i) => tone({ f, dur: .9, type: 'triangle', vol: .08, delay: i * .1, rev: .8 })); },
    title() { tone({ f: 110, dur: 3, type: 'sine', vol: .3, rev: 1 }); tone({ f: 165, dur: 3, type: 'sine', vol: .15, delay: .2, rev: 1 }); tone({ f: 233, dur: 3, type: 'triangle', vol: .08, delay: .4, rev: 1 }); },
    door() { tone({ f: 60, f2: 40, dur: 1, type: 'sawtooth', vol: .25, lp: 300 }); noise({ ft: 'lowpass', f: 400, dur: 1, vol: .3 }); },
    death() { tone({ f: 180, f2: 30, dur: 2.2, type: 'sawtooth', vol: .3, lp: 500, rev: .9 }); noise({ ft: 'lowpass', f: 900, f2: 60, dur: 2, vol: .3, rev: .6 }); },
    bossDie() { FX.roar(); setTimeout(() => FX.slam(), 400); setTimeout(() => FX.death(), 900); },
    glitch() { for (let i = 0; i < 6; i++) noise({ ft: 'bandpass', f: 400 + Math.random() * 4000, q: 4, dur: .04, vol: .1, delay: i * .03 }); },
    pageTurn() { noise({ ft: 'highpass', f: 1500, f2: 4000, dur: .25, vol: .1 }); },
    glassBreak() { for (let i = 0; i < 7; i++) tone({ f: 2000 + Math.random() * 3500, dur: .15 + Math.random() * .2, type: 'triangle', vol: .05, delay: i * .025, rev: .5 }); },
    knock() { tone({ f: 100, f2: 60, dur: .1, type: 'sine', vol: .3 }); tone({ f: 110, f2: 60, dur: .1, type: 'sine', vol: .3, delay: .22 }); }
  };
  function play(name, a) {
    if (!ready || !FX[name]) return;
    if (name === 'hit' || name === 'slash') { if (!limited(name, 40)) return; }
    try { FX[name](a); } catch (e) { }
  }

  /* ---- همسات ---- */
  function whisper(intensity, pan) {
    if (!ready || horror === 0) return;
    intensity = (intensity === undefined ? .5 : intensity) * (horror === 1 ? .6 : horror === 3 ? 1.35 : 1);
    const t = ctx.currentTime, dur = rnd(1.3, 3.2);
    const src = ctx.createBufferSource(); src.buffer = noiseBuf; src.loop = true;
    src.playbackRate.value = rnd(.8, 1.2);
    const mix = ctx.createGain(); mix.gain.value = 1;
    const forms = [[rnd(350, 700), rnd(250, 900), 7], [rnd(1100, 1900), rnd(900, 2100), 9], [rnd(2300, 3400), rnd(2000, 3600), 10]];
    forms.forEach(([f0, f1, q], i) => {
      const bp = ctx.createBiquadFilter(); bp.type = 'bandpass'; bp.Q.value = q;
      bp.frequency.setValueAtTime(f0, t); bp.frequency.linearRampToValueAtTime(f1, t + dur);
      const g = ctx.createGain(); g.gain.value = [1, .8, .5][i] * 3.2;
      src.connect(bp); bp.connect(g); g.connect(mix);
    });
    const gate = ctx.createGain(); gate.gain.value = .5;
    const lfo = ctx.createOscillator(); lfo.frequency.value = rnd(3.5, 8);
    const lg = ctx.createGain(); lg.gain.value = .5;
    lfo.connect(lg); lg.connect(gate.gain);
    const env = ctx.createGain();
    const v = .55 * intensity;
    env.gain.setValueAtTime(.0001, t);
    env.gain.linearRampToValueAtTime(v, t + dur * .35);
    env.gain.linearRampToValueAtTime(.0001, t + dur);
    mix.connect(gate); gate.connect(env);
    const p = panner(pan === undefined ? rnd(-1, 1) : pan);
    let out = env;
    if (p) { p.pan.setValueAtTime(p.pan.value, t); p.pan.linearRampToValueAtTime(clamp(p.pan.value + rnd(-.6, .6), -1, 1), t + dur); env.connect(p); out = p; }
    out.connect(bus.amb);
    const r = ctx.createGain(); r.gain.value = .9; out.connect(r); r.connect(convolver);
    src.start(t, Math.random()); lfo.start(t);
    src.stop(t + dur + .1); lfo.stop(t + dur + .1);
  }

  /* ---- نبض القلب ---- */
  function heartbeat(strength) {
    if (!ready) return;
    const s = clamp(strength || .5, .2, 1);
    tone({ f: 62, f2: 38, dur: .18, type: 'sine', vol: .5 * s, bus: 'amb' });
    tone({ f: 56, f2: 34, dur: .2, type: 'sine', vol: .36 * s, delay: .2, bus: 'amb' });
  }

  /* ---- أجواء ---- */
  function startAmbient() {
    const o1 = ctx.createOscillator(), o2 = ctx.createOscillator(), o3 = ctx.createOscillator(), o4 = ctx.createOscillator();
    o1.type = 'sawtooth'; o1.frequency.value = 55;
    o2.type = 'sawtooth'; o2.frequency.value = 55.7;
    o3.type = 'sine'; o3.frequency.value = 27.5;
    o4.type = 'triangle'; o4.frequency.value = 77.8; // ثلاثي النغمات المتنافرة
    const lp = ctx.createBiquadFilter(); lp.type = 'lowpass'; lp.frequency.value = 160; lp.Q.value = 3;
    const g = ctx.createGain(); g.gain.value = .0001;
    const g4 = ctx.createGain(); g4.gain.value = .0001;
    const lfo = ctx.createOscillator(); lfo.frequency.value = .08;
    const lfoG = ctx.createGain(); lfoG.gain.value = 70;
    lfo.connect(lfoG); lfoG.connect(lp.frequency);
    o1.connect(lp); o2.connect(lp); o3.connect(lp); lp.connect(g); g.connect(bus.amb);
    o4.connect(g4); g4.connect(lp);
    const wind = ctx.createBufferSource(); wind.buffer = noiseBuf; wind.loop = true;
    const wf = ctx.createBiquadFilter(); wf.type = 'bandpass'; wf.frequency.value = 500; wf.Q.value = 1.4;
    const wg = ctx.createGain(); wg.gain.value = .0001;
    const wl = ctx.createOscillator(); wl.frequency.value = .11;
    const wlg = ctx.createGain(); wlg.gain.value = 260;
    wl.connect(wlg); wlg.connect(wf.frequency);
    wind.connect(wf); wf.connect(wg); wg.connect(bus.amb);
    [o1, o2, o3, o4, lfo, wind, wl].forEach(n => n.start());
    amb = { g, g4, lp, wg, wf };
    setAmbient(0.3, 0);
  }
  function setAmbient(dark, tension) {
    if (!ready || !amb) return;
    const t = ctx.currentTime;
    amb.g.gain.linearRampToValueAtTime(.05 + dark * .12, t + 1.5);
    amb.g4.gain.linearRampToValueAtTime(tension * .7, t + 1.5);
    amb.wg.gain.linearRampToValueAtTime(.015 + dark * .02, t + 1.5);
    amb.lp.frequency.linearRampToValueAtTime(130 + tension * 260, t + 1.5);
  }

  /* ---- موسيقى ---- */
  const N = { E2: 82.4, F2: 87.3, G2: 98, A2: 110, Bb2: 116.5, B2: 123.5, C3: 130.8, D3: 146.8, E3: 164.8, F3: 174.6, G3: 196, Ab3: 207.7, B3: 246.9, E4: 329.6, F4: 349.2 };
  function setMusic(m) { if (m !== mode) { lastMode = mode; mode = m; step = 0; if (ctx) nextT = ctx.currentTime + .1; } }
  function musicTick() {
    if (!ready || mode === 'none' || vol.music <= 0) return;
    if (ctx.state === 'suspended') return;
    const now = ctx.currentTime;
    if (nextT < now - 1) nextT = now;
    while (nextT < now + .3) {
      const dt = scheduleStep(nextT, step);
      step++; nextT += dt;
    }
  }
  function kick(t, v) {
    const o = ctx.createOscillator(), g = ctx.createGain();
    o.frequency.setValueAtTime(130, t); o.frequency.exponentialRampToValueAtTime(38, t + .18);
    g.gain.setValueAtTime(v, t); g.gain.exponentialRampToValueAtTime(.001, t + .28);
    o.connect(g); g.connect(bus.music); o.start(t); o.stop(t + .3);
  }
  function mtone(t, f, dur, type, v, lp, rev) {
    const o = ctx.createOscillator(), g = ctx.createGain();
    o.type = type; o.frequency.value = f;
    g.gain.setValueAtTime(.0001, t); g.gain.linearRampToValueAtTime(v, t + Math.min(.05, dur * .3)); g.gain.exponentialRampToValueAtTime(.0001, t + dur);
    let out = g; o.connect(g);
    if (lp) { const f2 = ctx.createBiquadFilter(); f2.type = 'lowpass'; f2.frequency.value = lp; g.connect(f2); out = f2; }
    out.connect(bus.music);
    if (rev) { const r = ctx.createGain(); r.gain.value = rev; out.connect(r); r.connect(convolver); }
    o.start(t); o.stop(t + dur + .05);
  }
  function mnoise(t, dur, v, ft, f) {
    const s = ctx.createBufferSource(); s.buffer = noiseBuf;
    const fl = ctx.createBiquadFilter(); fl.type = ft; fl.frequency.value = f;
    const g = ctx.createGain(); g.gain.setValueAtTime(v, t); g.gain.exponentialRampToValueAtTime(.001, t + dur);
    s.connect(fl); fl.connect(g); g.connect(bus.music); s.start(t, Math.random()); s.stop(t + dur + .02);
  }
  const phr = [N.E2, N.F2, N.G2, N.A2, N.Bb2, N.C3, N.D3, N.E3, N.F3];
  function scheduleStep(t, s) {
    if (mode === 'explore') {
      // نغمات جرس متقطعة مع طبل بعيد
      if (s % 8 === 0 && Math.random() < .55) {
        const f = pick(phr) * (Math.random() < .3 ? 2 : 1);
        mtone(t, f, 4, 'sine', .11, 1200, .9); mtone(t, f * 2.76, 2.5, 'sine', .035, 3000, .9);
      }
      if (s % 32 === 0) { mtone(t, N.E2, 8, 'sawtooth', .05, 220, .6); mtone(t, N.F2, 8, 'sawtooth', .03, 200, .6); }
      if (s % 16 === 12 && Math.random() < .25) kick(t, .18);
      return .5;
    }
    if (mode === 'menu') {
      if (s % 8 === 0) { const f = pick([N.E2, N.G2, N.B2, N.E3]); mtone(t, f, 5, 'sine', .13, 900, 1); mtone(t, f * 1.5, 5, 'sine', .05, 900, 1); }
      if (s % 32 === 0) { mtone(t, N.E2, 10, 'sawtooth', .06, 200, .8); mtone(t, N.F2, 10, 'sawtooth', .04, 180, .8); }
      return .6;
    }
    if (mode === 'combat') {
      const p = s % 16;
      if (p === 0 || p === 6 || p === 10) kick(t, .5);
      if (p === 4 || p === 12) mnoise(t, .18, .22, 'bandpass', 1800);
      if (p % 2 === 1) mnoise(t, .05, .05, 'highpass', 7000);
      if (p === 0) { mtone(t, N.E2, .9, 'sawtooth', .13, 500, .2); mtone(t, N.F2, .9, 'sawtooth', .1, 500, .2); }
      if (p === 8) { mtone(t, N.G2, .5, 'sawtooth', .1, 600, .2); mtone(t, N.Ab3 / 2, .5, 'sawtooth', .08, 600, .2); }
      if (p === 14) mtone(t, N.B3, .25, 'square', .04, 1800, .5);
      return .105;
    }
    if (mode === 'boss') {
      const p = s % 32;
      if (p % 8 === 0) kick(t, .6);
      if (p === 6 || p === 22) kick(t, .45);
      if (p === 14 || p === 30) { mnoise(t, .3, .3, 'bandpass', 900); mtone(t, 60, .4, 'sine', .4, 200); }
      if (p % 4 === 2) mnoise(t, .04, .04, 'highpass', 8000);
      if (p === 0) { // جوقة نشاز
        [N.E3, N.F3, N.B3, N.E4, N.F4].forEach((f, i) => { mtone(t, f, 3.4, 'sawtooth', .035, 900 + i * 100, .8); mtone(t, f * 1.004, 3.4, 'sawtooth', .03, 900, .8); });
        mtone(t, N.E2 / 2, 3.4, 'sawtooth', .14, 150, .3);
      }
      if (p === 16) { [N.G3, N.Ab3, N.D3 * 2].forEach(f => mtone(t, f, 3, 'sawtooth', .03, 800, .8)); }
      if (p === 24 || p === 28) mtone(t, N.F2, .3, 'sawtooth', .12, 500, .3);
      return .12;
    }
    return .5;
  }
  function stopAll() { mode = 'none'; }

  /* ---- أصوات الشخصيات ---- */
  const VOICES = {
    sabir: { f: 105, type: 'triangle', len: .09, v: .14, lp: 700, rev: .3 },
    nadia: { f: 250, type: 'sawtooth', len: .07, v: .1, lp: 1500, rev: .5, shimmer: 2 },
    yusuf: { f: 780, type: 'sine', len: .22, v: .1, lp: 3000, rev: .8, hum: true },
    shaker: { f: 165, type: 'square', len: .06, v: .08, lp: 650, rev: .2, click: true },
    raed: { f: 135, type: 'sawtooth', len: .1, v: .09, lp: 500, rev: .4, breathy: true },
    hashem: { f: 88, type: 'square', len: .08, v: .1, lp: 800, rev: .7 },
    butcher: { f: 55, type: 'sawtooth', len: .14, v: .2, lp: 400, rev: .3 },
    collector: { f: 330, type: 'sine', len: .2, v: .09, lp: 2500, rev: 1, choir: true },
    whisper: { f: 200, type: 'sine', len: .1, v: .05, lp: 600, rev: 1, breathy: true },
    mod: { f: 180, type: 'triangle', len: .07, v: .1, lp: 1200, rev: .3 },
    narr: null
  };
  function speak(id, ch) {
    if (!ready) return;
    const v = VOICES[id]; if (!v) return;
    if (!limited('speak', 38)) return;
    const base = v.f * Math.pow(2, (Math.floor(Math.random() * 7) - 3) / 12 * (v.hum ? 0 : 1));
    if (v.hum) { const sc = [0, 2, 4, 7, 9, 12, 14]; const f = v.f * Math.pow(2, pick(sc) / 12); tone({ f, dur: v.len, type: 'sine', vol: v.v, lp: v.lp, rev: v.rev, bus: 'voice' }); tone({ f: f * 2, dur: v.len * .7, type: 'sine', vol: v.v * .3, lp: v.lp, rev: v.rev, bus: 'voice' }); return; }
    tone({ f: base, f2: base * rnd(.9, 1.1), dur: v.len, type: v.type, vol: v.v, lp: v.lp, rev: v.rev, bus: 'voice', a: .01 });
    if (v.shimmer) tone({ f: base * v.shimmer, dur: v.len * 1.5, type: 'triangle', vol: v.v * .4, lp: 3000, rev: .8, bus: 'voice' });
    if (v.click) noise({ ft: 'highpass', f: 4000, dur: .02, vol: .08, bus: 'voice' });
    if (v.breathy) noise({ ft: 'bandpass', f: 1500, q: 1, dur: v.len * 1.5, vol: .05, bus: 'voice' });
    if (v.choir) { tone({ f: base * 1.5, dur: v.len * 1.5, type: 'sine', vol: v.v * .6, rev: 1, bus: 'voice', detune: 15 }); tone({ f: base * 1.25, dur: v.len * 1.5, type: 'sine', vol: v.v * .5, rev: 1, bus: 'voice', detune: -15 }); }
    if (id === 'butcher' || id === 'hashem') noise({ ft: 'lowpass', f: 400, dur: v.len, vol: .08, bus: 'voice' });
  }
  function resume() { if (ctx && ctx.state === 'suspended') ctx.resume(); }
  return { init, resume, play, whisper, heartbeat, setAmbient, setMusic, setVolumes, setHorror, speak, stopAll, tone, noise, VOICES, get ready() { return ready; }, _ctx: () => ctx, _fx: FX };
})();

</script>
<script>
'use strict';
/* ===== بيانات اللعبة: الصعوبات، الشخصيات، الحوارات، القصة، المناطق ===== */

const DIFFS = [
  { id: 0, name: 'الزائر', desc: 'للقصة فقط. أعداء أضعف، وعقلك يصمد أطول، ولا تخسر شيئاً عند السقوط.', enemyHp: .6, dmgTaken: 1, playerDmg: 1.25, soul: 1.5, sanity: .35, boss: .75, death: 'none', color: '#8fb98f' },
  { id: 1, name: 'المتعقِّب', desc: 'تجربة مخففة. مناسبة لمن يريد التعرف على العالم بأمان نسبي.', enemyHp: .85, dmgTaken: 1, playerDmg: 1.1, soul: 1.2, sanity: .7, boss: .9, death: 'shade', color: '#b9b98f' },
  { id: 2, name: 'الكابوس', desc: 'التجربة الأساسية كما صُمّمت. القتال عادل لكنه لا يرحم الأخطاء.', enemyHp: 1, dmgTaken: 1, playerDmg: 1, soul: 1, sanity: 1, boss: 1, death: 'shade', color: '#c9a45c' },
  { id: 3, name: 'العمى', desc: 'ضربات الزعماء تُصيب بضعف. العقل ينهار بسرعة، وتفقد نصف رمادك عند السقوط.', enemyHp: 1.35, dmgTaken: 1.5, playerDmg: 1, soul: .85, sanity: 1.5, boss: 1.2, death: 'harsh', color: '#c9704c' },
  { id: 4, name: 'الجدار الأخير', desc: 'موتة واحدة تعني النهاية: يُمحى الحفظ كله. لمن يريد أن يشعر بالخوف حقاً.', enemyHp: 1.7, dmgTaken: 2, playerDmg: 1, soul: .75, sanity: 2, boss: 1.4, death: 'perma', color: '#b32d2d' }
];

const ENEMIES = {
  husk: { name: 'الهائم', hp: 12, w: 22, h: 34, speed: 55, chase: 120, dmg: 1, soul: 11, ash: [2, 4], kind: 'walker', sight: 230, col: '#2a2f38' },
  crawler: { name: 'الزاحف', hp: 10, w: 30, h: 20, speed: 40, chase: 70, dmg: 1, soul: 11, ash: [1, 3], kind: 'crawler', sight: 260, col: '#33262a' },
  eye: { name: 'العين الطافية', hp: 8, w: 28, h: 28, speed: 50, chase: 85, dmg: 1, soul: 11, ash: [2, 4], kind: 'flyer', sight: 340, col: '#3a2d33' },
  guard: { name: 'الحارس المقنّع', hp: 26, w: 26, h: 42, speed: 40, chase: 70, dmg: 1, soul: 16, ash: [6, 10], kind: 'guard', sight: 260, col: '#22252c', armored: true }
};

const BOSSES = {
  butcher: { name: 'الجزّار الأعمى', title: 'من كان يُصلح الأبواب', hp: 380, w: 58, h: 78, voice: 'butcher', ash: 140 },
  collector: { name: 'أمّ العيون', title: 'جامعة النظرات', hp: 340, w: 44, h: 76, voice: 'collector', ash: 180 },
  commander: { name: 'القائد هاشم', title: 'كبير المتعقِّبين', hp: 480, w: 34, h: 64, voice: 'hashem', ash: 260 }
};

const NPCS = {
  sabir: { name: 'صابر', role: 'مُشعل القناديل', col: '#c9a45c', w: 24, h: 40, kind: 'old' },
  nadia: { name: 'نادية', role: 'بائعة المرايا', col: '#9bb7c9', w: 24, h: 40, kind: 'veil' },
  yusuf: { name: 'يوسف', role: 'طفل لا يتكلم', col: '#bbbbbb', w: 18, h: 24, kind: 'child' },
  shaker: { name: 'شاكر', role: 'الخيّاط', col: '#a98f6a', w: 26, h: 38, kind: 'tailor' },
  raed: { name: 'رائد', role: 'متعقِّب جريح', col: '#7d9aa8', w: 30, h: 22, kind: 'hurt' }
};

const ITEMS = {
  lantern: { name: 'قنديل صابر', desc: 'يخفّف أثر الظلام على عقلك بمقدار الثلث.' },
  mirror: { name: 'المرآة الصغيرة', desc: 'الرؤية البديلة لا تُنهك عقلك بعد اليوم.' },
  shard: { name: 'شظية مرآة', desc: 'كل ما يستنزف عقلك يضعف بمقدار الخُمس.' },
  drawing: { name: 'رسمة يوسف', desc: 'تُظهر علامات الأسرار القريبة بوهج خافت.' },
  wings: { name: 'ريش الغراب', desc: 'قفزة ثانية في الهواء.' },
  glass_eye: { name: 'العين الزجاجية', desc: 'عين لا تبصر، لكنها تبدو وكأنها تراقبك. نادية تبحث عنها.' },
  badge: { name: 'شارة رائد', desc: 'ما همس به عن القائد يُثبّت عقلك أمام الزعماء.' },
  blade: { name: 'نصل الرحمة', desc: 'أنهيتَ ألماً بيدك. سيفك أثقل بمقدار عُشر.' }
};

const TITLES = {
  lamp: 'حامل القنديل', silent: 'من جلس بصمت', friend: 'رفيق الصغير', mirrors: 'صديق المرايا',
  thread: 'شاهد الخيط', merciful: 'الرحيم', stern: 'الصارم', butcherSlayer: 'قاتل الجزّار',
  collectorSlayer: 'كاسر النظرات', commander: 'كاسر العهد', seer: 'ذو البصيرة', curious: 'الفضولي',
  stubborn: 'الذي لا ينحني', steady: 'الثابت', mad: 'من سمع النداء'
};

const LORE = {
  l1: { title: 'ورقة من جيب مخطوف', text: 'اليوم الثالث. أخبروني أنني لن أتألم. لم أتألم فعلاً. كل ما أذكره أنهم طلبوا مني أن أنظر في المرآة طويلاً، ثم أن أغمض عينيّ… ثم لا شيء. لا شيء إلا ضوءٌ أبيض، ونداءٌ باسمي.' },
  l2: { title: 'أمر المتعقّبين رقم ٧', text: 'على كل فرد أن يبلّغ قائد الفرقة بما يجده في الأزقة قبل أن يخبر أي أحد. لا يُعلَن عن أي أثرٍ يتعلق بالمرايا.\n— القيادة' },
  l3: { title: 'مفكرة الجزّار', text: 'كنتُ أصلح الأبواب. قالوا لي: افتح الباب هذه الليلة فقط. وفتحت. وفي الليلة التالية قالوا: أغلقه خلفهم. ثم صار الباب هو أنا. أراهم الآن… كلهم. أطفئوا النظرات.' },
  l4: { title: 'رسالة بلا عنوان', text: 'إلى «م»: الأعداد تكتمل. ثلاثمئة وأربعون زوجاً. اللعنة تحتاج ألفاً. الدولة ستدفع بقية الثمن عند اكتمال الجدار الثاني. لا تدع الفرقة الجديدة تقترب من القبو.' },
  l5: { title: 'سجلّ أمّ العيون', text: 'رقم ١٢٧: عينان زرقاوان لطفلة. رقم ١٢٨: عين واحدة لحدّاد. … رقم ٢٠٣: تشبه عينيّ قبل أن أنسى لون عينيّ.' },
  l6: { title: 'ملاحظة الخيّاط', text: 'لا أعرف ما يُفعل بها، لكنني أعرف أن لكل عين وزناً. التي رأت حباً أثقل من التي رأت جوعاً. وأنا أخيط ما ثقل.' },
  l7: { title: 'ورقة من برج الأسوار', text: 'إلى القائد هـ: الصفقة قائمة. تسلّمون الأعداد الباقية قبل الاعتدال. والمرآة تُبلّغنا بما تقولونه.\n— من خلف الجدار الآخر' },
  l8: { title: 'نقش على الجدار', text: 'من يكتب هذا يعلم أنه لن ينجو: الذين خلف الجدار الآخر لا يريدون ما نراه. يريدون ما نحن عاجزون عن رؤيته.' },
  l9: { title: 'ورقة الطفل', text: 'عيون كثيرة. إحداها عين رجلٍ بلا وجه. وتحتها بخطٍ طفولي مائل: «لا تنظر إلى الأعلى. إنه يرى من هناك».' }
};

const WHISPERS = [
  'لا تلتفت…', 'نحن نراك', 'عينك لي', 'الجدار يتنفس', 'ليس هنا أحد… ليس هنا أحد', 'أعد لي عيني', 'هو خلفك',
  'اسمك ليس اسمك', 'كم ترى؟ كم تذكر؟', 'الضوء يكذب', 'أغمض عينيك… أرجوك', 'لقد رأيتَ أكثر مما يجب',
  'افتح الباب… افتح الباب', 'إنها تبتسم', 'لا تثق بالمرايا', 'كنتَ هنا من قبل', 'من يحرس الحارس؟',
  'الظلام ليس غياب الضوء… إنه حضورُ شيءٍ آخر'
];
const WHISPERS_LOW = [
  'أنت لستَ المتعقِّب… أنت الأثر', 'ما زلتَ تظنّ أن عينيك لك؟', 'تحت الأرض ما زالوا يعدّون', 'التفتْ… التفتْ فقط',
  'سنكون لطفاء', 'لماذا تركض؟ نحن بداخلك', 'اللعنة تحتاج إلى عينٍ أخيرة'
];

const CARDS_INTRO = [
  'خلف الجدار… كانت المدينة تنام وعيونها مفتوحة.',
  'ثم بدأ الناس يختفون. يعودون بعد ثلاث ليالٍ بلا عيون، وبلا ذاكرة لما رأوه.',
  'فتشكّل المتعقِّبون: رجالٌ ونساء أقسموا أن يتتبعوا الأثر إلى آخره.',
  'وأنت… أول من يُرسَل إلى الأزقة العمياء.',
  'لا تثق بما ترى. فقد يكون هذا بالضبط ما يريدونه.'
];

/* ===== الحوارات =====
   العقدة: { who, t (نص أو مصفوفة)، go، choices:[{t,go,set,give,cost,req,reqNot}]، end، set، give }
   give: {item,title,ash,sanity,hp,maxHp,nail,takeItem}  */
const DIALOGUES = {
  sabir_1: {
    npc: 'sabir', start: 'start', nodes: {
      start: { who: 'sabir', t: 'اقترب… لا، لا تتكلم. خطواتك ثقيلة، كخطوات من يحمل أمراً لا يريده.', go: 'a' },
      a: { who: 'sabir', t: 'أنا صابر. أُشعل هذه القناديل منذ أربعين سنة، ومنذ ثلاثين لا أراها. هل يهمّ؟ الضوء لا يسأل عمّن يراه.', choices: [
        { t: 'كيف تُشعل ما لا تراه؟', go: 'q1' }, { t: 'قيل إن العميان لا يُخطَفون.', go: 'q2' }, { t: 'ليس عندي وقت لهذا.', go: 'rude' }] },
      q1: { who: 'sabir', t: 'بالإيمان يا ولدي. العين تُريك ما هو كائن، أما اليد فتعرف ما ينبغي أن يكون. فأيّهما أصدق في رأيك؟', choices: [
        { t: 'اليد.', go: 'hand', set: { sabir_view: 'hand' } }, { t: 'العين.', go: 'eye', set: { sabir_view: 'eye' } }] },
      hand: { who: 'sabir', t: 'جيد. ستحتاج يدك أكثر من عينك في الأسفل… العيون هناك تُخدَع بسهولة.', go: 'gift' },
      eye: { who: 'sabir', t: 'ربما. لكن انتبه: كل من فقدوا عيونهم كانوا واثقين بها أكثر مما ينبغي.', go: 'gift' },
      q2: { who: 'sabir', t: 'ههه… هذا ما ظنّه الجميع. جاؤوا إليّ ليلة أمس. وقفوا حولي طويلاً وصمتوا، ثم غادروا ولم يأخذوا شيئاً. أتعرف لماذا؟', choices: [
        { t: 'لأنك لا تصلح لما يريدونه.', go: 'q2b' }, { t: 'لأنهم أرادوك أن تخبرني.', go: 'q2c' }] },
      q2b: { who: 'sabir', t: 'قريب. الذي يريدونه ليس العيون ذاتها… بل ما رأته العيون. كل ما يشاهده المرء يمرّ عبرها ثم يبقى هناك. فاسأل نفسك: ماذا رأى المخطوفون؟', go: 'gift' },
      q2c: { who: 'sabir', t: 'إمّا أنك ذكي أو مرتاب. وكلاهما يُبقي صاحبه حياً.', go: 'gift' },
      rude: { who: 'sabir', t: 'الوقت… الشيء الوحيد الذي لا يملكه أحد، ومع ذلك يتخاصم عليه الجميع. اذهب. وعُد حين تتعب من الركض.', set: { sabir_rude: true }, end: true },
      gift: { who: 'sabir', t: 'خذ هذا. قنديل قديم. لا يكشف لك الطريق، لكنه يُذكّرك بأن في هذا العالم مكاناً لم يبلغه الظلام بعد.', give: { item: 'lantern', title: 'lamp', sanity: 25 }, set: { sabir_met: true, sabir_rude: false }, go: 'last' },
      last: { who: 'sabir', t: 'وتذكّر: الخوف ليس عدوّك. عدوّك هو الذي يريدك أن تخاف وحدك.', end: true }
    }
  },
  sabir_idle: {
    npc: 'sabir', start: 'start', nodes: {
      start: { who: 'sabir', t: ['الظلام لا يخيف من يعرف أين يقف.', 'أسمع قلبك يسرع. هذا حسن… الميت لا يخاف.', 'كل قنديل أشعله هو جوابٌ على سؤال لم يسأله أحد.', 'إن سمعتَ من يهمس باسمك، فتذكّر أن الأسماء تُعطى ولا تُؤخذ.'], end: true }
    }
  },
  sabir_after: {
    npc: 'sabir', start: 'start', nodes: {
      start: { who: 'sabir', t: 'سمعتُ زئيره يتوقف… الجزّار كان رجلاً قبل أن يصير ما صار. لا تنسَ ذلك.', choices: [
        { t: 'كان وحشاً يا صابر.', go: 'm1' }, { t: 'وماذا كان؟', go: 'm2' }] },
      m1: { who: 'sabir', t: 'الوحش هو إنسانٌ توقّف عن السؤال. وأنا لا أخاف الوحوش بقدر ما أخاف الذين يصنعونها. خذ، هذا ما تيسّر.', set: { sabir_after_done: true }, give: { ash: 30 }, end: true },
      m2: { who: 'sabir', t: 'رجلٌ كان يصلح الأبواب. ثم أرادوا منه أن «يصلح» ما هو أصعب. هذه هي القصة دائماً: يطلبون من الطيّب ما لا يطيقه، ثم يسمّونه وحشاً حين ينكسر.', set: { sabir_after_done: true }, give: { ash: 30 }, end: true }
    }
  },
  nadia_1: {
    npc: 'nadia', start: 'start', nodes: {
      start: { who: 'nadia', t: 'مرايا… جديدة، قديمة، وبعضها لم يرَ وجهاً قط. أنت من المتعقبين، أليس كذلك؟ رأيتُ شارتك قبل أن تصل. المرآة تخبرني بكل شيء قبل أن يتكلم أصحابها.', go: 'hub' },
      hub: { who: 'nadia', t: 'ماذا تريد أن تعرف؟', choices: [
        { t: 'ماذا ترين في المرآة الآن؟', go: 'see' }, { t: 'هل رأيتِ أحداً يُخطَف؟', go: 'saw' },
        { t: 'أريد أن أشتري شيئاً.', go: 'shop' }, { t: 'سأذهب.', go: 'bye' }] },
      see: { who: 'nadia', t: 'أرى رجلاً يمشي نحو شيء يظنّ أنه اختاره. لكن في المرآة… هناك من يمشي خلفه بنفس الخطوات.', choices: [
        { t: 'من الذي يمشي خلفي؟', go: 'follow' }, { t: 'هذا يكفي.', go: 'hub' }] },
      follow: { who: 'nadia', t: 'المرآة لا تجيب عن الأسئلة يا متعقّب. هي تُريك فقط أنك لم تكن وحدك يوماً. وتحذير أخير: إن سمعتَ من يناديك باسمك في الظلام فلا تُجب. ليس لأن النداء كذب… بل لأنه صادق أكثر مما يجب.', set: { nadia_warned: true }, go: 'hub' },
      saw: { who: 'nadia', t: 'رأيتُ ما بعد الخطف. رجلاً عاد ويداه تتحسسان وجهه كأنه يبحث عن شيءٍ وضعه في مكان ما. قال لي: «كانوا لطفاء». هذا ما يخيفني… الجلّادون الذين يُحسنون الضيافة.', choices: [
        { t: 'من يكونون؟', go: 'who' }, { t: 'ولماذا يريدون العيون؟', go: 'who' }] },
      who: { who: 'nadia', t: 'لو كنتُ أعرف لما بقيتُ أبيع المرايا. لكن الغريب أن الذي طلبوه ليس العيون… بل أن ينظر الضحية في المرآة قبل أن تُؤخذ. كأن النظرة نفسها هي الثمن.', go: 'quest' },
      quest: { who: 'nadia', t: 'وإن وجدتَ في الأسفل عيناً من زجاج… أحضرها لي. إنها تخصّني. أرجوك.', set: { nadia_quest: true }, go: 'hub' },
      shop: { who: 'nadia', t: 'ليست كل المرايا للنظر. هذه الشظية تُخفّف ما يتسلل إلى رأسك في الظلام. أربعون رماداً.', choices: [
        { t: 'اشترِ الشظية (40 رماد)', go: 'bought', cost: 40, give: { item: 'shard' }, reqNot: { item: 'shard' } },
        { t: 'ربما لاحقاً.', go: 'hub' }] },
      bought: { who: 'nadia', t: 'حسن. احملها قريبةً من قلبك. لا تُحدّق بها طويلاً.', go: 'hub' },
      bye: { who: 'nadia', t: 'ستعود. الجميع يعودون إلى المرايا في النهاية.', end: true }
    }
  },
  nadia_glass: {
    npc: 'nadia', start: 'start', nodes: {
      start: { who: 'nadia', t: 'هل… هل وجدتَها؟', choices: [
        { t: 'سلّمها لنادية.', go: 'give' }, { t: 'سأحتفظ بها.', go: 'keep' }] },
      give: { who: 'nadia', t: 'شكراً… لا تدري كم هي ثمينة. ليست عيناً… إنها نافذة. خذ هذه المرآة الصغيرة مقابلها. ستريك أموراً حين تُحدّق بصدق.', give: { item: 'mirror', title: 'mirrors', takeItem: 'glass_eye' }, set: { nadia_trust: true }, end: true },
      keep: { who: 'nadia', t: 'أفهمك. كلنا نحتفظ بما يخيفنا.', set: { nadia_refused: true }, end: true }
    }
  },
  nadia_idle: {
    npc: 'nadia', start: 'start', nodes: {
      start: { who: 'nadia', t: 'المرآة لا تكذب. لكنها تقلب كل شيء.', choices: [
        { t: 'أريد أن أشتري شيئاً.', go: 'shop' }, { t: 'إل