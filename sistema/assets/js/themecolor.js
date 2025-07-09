// Proteção contra redefinição global
if (typeof window.html === "undefined") {
  window.html = document.querySelector("html");
}
if (typeof window.body === "undefined") {
  window.body = document.querySelector("body");
}

if (typeof window.handleThemeUpdate === "undefined") {
  window.handleThemeUpdate = (cssVars) => {
    const root = document.querySelector(":root");
    const keys = Object.keys(cssVars);
    keys.forEach((key) => {
      root.style.setProperty(key, cssVars[key]);
    });
  };
}

if (typeof window.isValidHex === "undefined") {
  window.isValidHex = (hexValue) => /^#([A-Fa-f0-9]{3,4}){1,2}$/.test(hexValue);
}
if (typeof window.getChunksFromString === "undefined") {
  window.getChunksFromString = (st, chunkSize) =>
    st.match(new RegExp(`.{${chunkSize}}`, "g"));
}
if (typeof window.convertHexUnitTo256 === "undefined") {
  window.convertHexUnitTo256 = (hexStr) =>
    parseInt(hexStr.repeat(2 / hexStr.length), 16);
}
if (typeof window.getAlphafloat === "undefined") {
  window.getAlphafloat = (a, alpha) => {
    if (typeof a !== "undefined") {
      return a / 255;
    }
    if (typeof alpha != "number" || alpha < 0 || alpha > 1) {
      return 1;
    }
    return alpha;
  };
}
if (typeof window.hexToRgba === "undefined") {
  window.hexToRgba = function (hexValue, alpha = 1) {
    if (!window.isValidHex(hexValue)) {
      return null;
    }
    const chunkSize = Math.floor((hexValue.length - 1) / 3);
    const hexArr = window.getChunksFromString(hexValue.slice(1), chunkSize);
    const [r, g, b, a] = hexArr.map(window.convertHexUnitTo256);
    return `rgba(${r}, ${g}, ${b}, ${window.getAlphafloat(a, alpha)})`;
  };
}

// Proteção contra redefinição global para variáveis de cor
if (typeof window.myVarVal === "undefined") window.myVarVal = undefined;
if (typeof window.myVarVal1 === "undefined") window.myVarVal1 = undefined;
if (typeof window.myVarVal2 === "undefined") window.myVarVal2 = undefined;
if (typeof window.myVarVal3 === "undefined") window.myVarVal3 = undefined;

function dynamicPrimaryColor(primaryColor) {
  primaryColor.forEach((item) => {
    item.addEventListener("input", (e) => {
      const cssPropName = `--primary-${e.target.getAttribute("data-id")}`;
      const cssPropName1 = `--primary-${e.target.getAttribute("data-id1")}`;
      const cssPropName2 = `--primary-${e.target.getAttribute("data-id2")}`;
      const cssPropName7 = `--primary-${e.target.getAttribute("data-id7")}`;
      const cssPropName8 = `--darkprimary-${e.target.getAttribute("data-id8")}`;
      const cssPropName3 = `--dark-${e.target.getAttribute("data-id3")}`;
      const cssPropName4 = `--transparent-${e.target.getAttribute("data-id4")}`;
      const cssPropName5 = `--transparent-${e.target.getAttribute("data-id5")}`;
      const cssPropName6 = `--transparent-${e.target.getAttribute("data-id6")}`;
      const cssPropName9 = `--transparentprimary-${e.target.getAttribute(
        "data-id9"
      )}`;
      window.handleThemeUpdate({
        [cssPropName]: e.target.value,
        // 95 is used as the opacity 0.95
        [cssPropName1]: e.target.value + 95,
        [cssPropName2]: e.target.value,
        [cssPropName3]: e.target.value,
        [cssPropName4]: e.target.value,
        [cssPropName5]: e.target.value,
        [cssPropName6]: e.target.value + 95,
        [cssPropName7]: e.target.value + 20,
        [cssPropName8]: e.target.value + 20,
        [cssPropName9]: e.target.value + 20,
      });
    });
  });
}

(function () {
  "use strict";
  // Light theme color picker
  const LightThemeSwitchers = document.querySelectorAll(
    ".light-theme .switch_section span"
  );
  const dynamicPrimaryLight = document.querySelectorAll(
    "input.color-primary-light"
  );

  // themeSwitch(LightThemeSwitchers);
  dynamicPrimaryColor(dynamicPrimaryLight);

  // dark theme color picker

  const DarkThemeSwitchers = document.querySelectorAll(
    ".dark-theme .switch_section span"
  );
  const DarkDynamicPrimaryLight = document.querySelectorAll(
    "input.color-primary-dark"
  );

  // themeSwitch(DarkThemeSwitchers);
  dynamicPrimaryColor(DarkDynamicPrimaryLight);

  // tranparent theme color picker

  const transparentThemeSwitchers = document.querySelectorAll(
    ".transparent-theme .switch_section span"
  );
  const transparentDynamicPrimaryLight = document.querySelectorAll(
    "input.color-primary-transparent"
  );

  // themeSwitch(transparentThemeSwitchers);
  dynamicPrimaryColor(transparentDynamicPrimaryLight);

  // tranparent theme bgcolor picker

  const transparentBgThemeSwitchers = document.querySelectorAll(
    ".transparent-theme .switch_section span"
  );
  const transparentDynamicPBgLight = document.querySelectorAll(
    "input.color-bg-transparent"
  );

  // themeSwitch(transparentBgThemeSwitchers);
  dynamicPrimaryColor(transparentDynamicPBgLight);

  localStorageBackup();

  $("#myonoffswitch1").on("click", function () {
    window.body?.classList.remove("dark-theme");
    window.body?.classList.remove("transparent-theme");
    window.body?.classList.remove("bg-img1");
    window.body?.classList.remove("bg-img2");
    window.body?.classList.remove("bg-img3");
    window.body?.classList.remove("bg-img4");

    localStorage.removeItem("nowaBgImage");
    $("#myonoffswitch1").prop("checked", true);

    localStorage.setItem("nowalightMode", true);
    localStorage.removeItem("nowadarkMode");
    localStorage.removeItem("nowatransparentMode");
  });
  $("#myonoffswitch2").on("click", function () {
    window.body?.classList.remove("light-theme");
    window.body?.classList.remove("transparent-theme");
    window.body?.classList.remove("bg-img1");
    window.body?.classList.remove("bg-img2");
    window.body?.classList.remove("bg-img3");
    window.body?.classList.remove("bg-img4");

    localStorage.setItem("nowadarkMode", true);
    localStorage.removeItem("nowalightMode");
    localStorage.removeItem("nowatransparentMode");

    localStorage.removeItem("nowaBgImage");
    $("#myonoffswitch2").prop("checked", true);
  });
  $("#myonoffswitchTransparent").on("click", function () {
    window.body?.classList.remove("dark-theme");
    window.body?.classList.remove("light-theme");
    window.body?.classList.remove("bg-img1");
    window.body?.classList.remove("bg-img2");
    window.body?.classList.remove("bg-img3");
    window.body?.classList.remove("bg-img4");

    localStorage.removeItem("nowaBgImage");
    $("#myonoffswitchTransparent").prop("checked", true);
    localStorage.setItem("nowatransparentMode", true);
    localStorage.removeItem("nowalightMode");
    localStorage.removeItem("nowadarkMode");
  });
})();

function localStorageBackup() {
  "use strict";
  // if there is a value stored, update color picker and background color
  // Used to retrive the data from local storage
  if (localStorage.nowaprimaryColor) {
    document.getElementById("colorID").value = localStorage.nowaprimaryColor;
    window.html.style.setProperty(
      "--primary-bg-color",
      localStorage.nowaprimaryColor
    );
    window.html.style.setProperty(
      "--primary-bg-hover",
      localStorage.nowaprimaryHoverColor
    );
    window.html.style.setProperty(
      "--primary-bg-border",
      localStorage.nowaprimaryBorderColor
    );
    window.html.style.setProperty(
      "--primary-transparentcolor",
      localStorage.nowaprimaryTransparent
    );
    // body.setAttribute('class', 'app sidebar-mini light-theme');

    window.body.classList.add("light-theme");
    window.body.classList.remove("dark-theme");
    window.body.classList.remove("transparent-theme");

    $("#myonoffswitch3").prop("checked", true);
    $("#myonoffswitch6").prop("checked", true);
    $("#myonoffswitch1").prop("checked", true);
  }

  if (localStorage.nowadarkPrimary) {
    document.getElementById("darkPrimaryColorID").value =
      localStorage.nowadarkPrimary;
    window.html.style.setProperty(
      "--primary-bg-color",
      localStorage.nowadarkPrimary
    );
    window.html.style.setProperty(
      "--primary-bg-hover",
      localStorage.nowadarkPrimary
    );
    window.html.style.setProperty(
      "--primary-bg-border",
      localStorage.nowadarkPrimary
    );
    window.html.style.setProperty(
      "--dark-primary",
      localStorage.nowadarkPrimary
    );
    window.html.style.setProperty(
      "--darkprimary-transparentcolor",
      localStorage.nowadarkprimaryTransparent
    );
    // body.setAttribute('class', 'app sidebar-mini dark-theme');

    window.body.classList.remove("light-theme");
    window.body.classList.add("dark-theme");
    window.body.classList.remove("transparent-theme");

    $("#myonoffswitch2").prop("checked", true);
  }

  if (localStorage.nowatransparentPrimary) {
    document.getElementById("transparentPrimaryColorID").value =
      localStorage.nowatransparentPrimary;
    window.html.style.setProperty(
      "--primary-bg-color",
      localStorage.nowatransparentPrimary
    );
    window.html.style.setProperty(
      "--primary-bg-hover",
      localStorage.nowatransparentPrimary
    );
    window.html.style.setProperty(
      "--primary-bg-border",
      localStorage.nowatransparentPrimary
    );
    window.html.style.setProperty(
      "--transparent-primary",
      localStorage.nowatransparentPrimary
    );
    window.html.style.setProperty(
      "--transparentprimary-transparentcolor",
      localStorage.nowatransparentprimaryTransparent
    );
    // body.setAttribute('class', 'app sidebar-mini transparent-theme');

    window.body.classList.remove("light-theme");
    window.body.classList.remove("dark-theme");
    window.body.classList.add("transparent-theme");

    $("#myonoffswitchTransparent").prop("checked", true);
  }

  if (localStorage.nowatransparentBgImgPrimary) {
    document.getElementById("transparentBgImgPrimaryColorID").value =
      localStorage.nowatransparentBgImgPrimary;
    window.html.style.setProperty(
      "--primary-bg-color",
      localStorage.nowatransparentBgImgPrimary
    );
    window.html.style.setProperty(
      "--primary-bg-hover",
      localStorage.nowatransparentBgImgPrimary
    );
    window.html.style.setProperty(
      "--primary-bg-border",
      localStorage.nowatransparentBgImgPrimary
    );
    window.html.style.setProperty(
      "--transparent-primary",
      localStorage.nowatransparentBgImgPrimary
    );
    window.html.style.setProperty(
      "--transparentprimary-transparentcolor",
      localStorage.nowatransparentBgImgprimaryTransparent
    );
    window.body?.classList.add("transparent-theme");
    window.body?.classList.remove("dark-theme");
    window.body?.classList.remove("light-theme");

    $("#myonoffswitchTransparent").prop("checked", true);
  }

  if (localStorage.nowatransparentBgColor) {
    document.getElementById("transparentBgColorID").value =
      localStorage.nowatransparentBgColor;
    window.html.style.setProperty(
      "--transparent-body",
      localStorage.nowatransparentBgColor
    );
    window.html.style.setProperty(
      "--transparent-theme",
      localStorage.nowatransparentThemeColor
    );
    window.html.style.setProperty(
      "--transparentprimary-transparentcolor",
      localStorage.nowatransparentprimaryTransparent
    );
    window.body.classList.add("transparent-theme");
    window.body.classList.remove("dark-theme");
    window.body.classList.remove("light-theme");

    $("#myonoffswitchTransparent").prop("checked", true);
  }
  if (localStorage.nowaBgImage) {
    window.body?.classList.add("transparent-theme");
    let bgImg = localStorage.nowaBgImage.split(" ")[0];
    window.body?.classList.add(bgImg);
    window.body?.classList.remove("dark-theme");
    window.body?.classList.remove("light-theme");

    $("#myonoffswitchTransparent").prop("checked", true);
  }

  if (localStorage.nowalightMode) {
    window.body?.classList.add("light-theme");
    window.body?.classList.remove("dark-theme");
    window.body?.classList.remove("transparent-theme");
    $("#myonoffswitch1").prop("checked", true);
    $("#myonoffswitch3").prop("checked", true);
    $("#myonoffswitch6").prop("checked", true);
  }
  if (localStorage.nowadarkMode) {
    window.body?.classList.remove("light-theme");
    window.body?.classList.add("dark-theme");
    window.body?.classList.remove("transparent-theme");
    $("#myonoffswitch2").prop("checked", true);
    $("#myonoffswitch5").prop("checked", true);
    $("#myonoffswitch8").prop("checked", true);
  }
  if (localStorage.nowatransparentMode) {
    window.body?.classList.remove("light-theme");
    window.body?.classList.remove("dark-theme");
    window.body?.classList.add("transparent-theme");
    $("#myonoffswitchTransparent").prop("checked", true);
    $("#myonoffswitch3").prop("checked", false);
    $("#myonoffswitch6").prop("checked", false);
    $("#myonoffswitch5").prop("checked", false);
    $("#myonoffswitch8").prop("checked", false);
  }
  if (localStorage.nowahorizontal) {
    window.body.classList.add("horizontal");
  }
  if (localStorage.nowahorizontalHover) {
    window.body.classList.add("horizontal-hover");
  }
  if (localStorage.nowartl) {
    window.body.classList.add("rtl");
  }
}

// triggers on changing the color picker
function changePrimaryColor() {
  "use strict";
  $("#myonoffswitch3").prop("checked", true);
  $("#myonoffswitch6").prop("checked", true);
  checkOptions();

  var userColor = document.getElementById("colorID").value;
  localStorage.setItem("nowaprimaryColor", userColor);
  // to store value as opacity 0.95 we use 95
  localStorage.setItem("nowaprimaryHoverColor", userColor + 95);
  localStorage.setItem("nowaprimaryBorderColor", userColor);
  localStorage.setItem("nowaprimaryTransparent", userColor + 20);

  // removing dark theme properties
  localStorage.removeItem("nowadarkPrimary");
  localStorage.removeItem("nowatransparentBgColor");
  localStorage.removeItem("nowatransparentThemeColor");
  localStorage.removeItem("nowatransparentPrimary");
  localStorage.removeItem("nowatransparentBgImgPrimary");
  localStorage.removeItem("nowatransparentBgImgprimaryTransparent");
  localStorage.removeItem("nowadarkprimaryTransparent");
  window.body.classList.add("light-theme");
  window.body.classList.remove("transparent-theme");
  window.body.classList.remove("dark-theme");
  localStorage.removeItem("nowaBgImage");

  $("#myonoffswitch1").prop("checked", true);
  names();

  localStorage.setItem("nowalightMode", true);
  localStorage.removeItem("nowadarkMode");
  localStorage.removeItem("nowatransparentMode");
}

function darkPrimaryColor() {
  "use strict";

  var userColor = document.getElementById("darkPrimaryColorID").value;
  localStorage.setItem("nowadarkPrimary", userColor);
  localStorage.setItem("nowadarkprimaryTransparent", userColor + 20);
  $("#myonoffswitch5").prop("checked", true);
  $("#myonoffswitch8").prop("checked", true);
  checkOptions();

  // removing light theme data
  localStorage.removeItem("nowaprimaryColor");
  localStorage.removeItem("nowaprimaryHoverColor");
  localStorage.removeItem("nowaprimaryBorderColor");
  localStorage.removeItem("nowaprimaryTransparent");
  localStorage.removeItem("nowatransparentBgImgPrimary");
  localStorage.removeItem("nowatransparentBgImgprimaryTransparent");

  localStorage.removeItem("nowatransparentBgColor");
  localStorage.removeItem("nowatransparentThemeColor");
  localStorage.removeItem("nowatransparentPrimary");
  localStorage.removeItem("nowaBgImage");

  window.body.classList.add("dark-theme");
  window.body.classList.remove("light-theme");
  window.body.classList.remove("transparent-theme");

  $("#myonoffswitch2").prop("checked", true);
  names();

  localStorage.setItem("nowadarkMode", true);
  localStorage.removeItem("nowalightMode");
  localStorage.removeItem("nowatransparentMode");
}

function transparentPrimaryColor() {
  "use strict";

  $("#myonoffswitch3").prop("checked", false);
  $("#myonoffswitch6").prop("checked", false);
  $("#myonoffswitch5").prop("checked", false);
  $("#myonoffswitch8").prop("checked", false);

  var userColor = document.getElementById("transparentPrimaryColorID").value;
  localStorage.setItem("nowatransparentPrimary", userColor);
  localStorage.setItem("nowatransparentprimaryTransparent", userColor + 20);

  // removing light theme data
  localStorage.removeItem("nowadarkPrimary");
  localStorage.removeItem("nowaprimaryColor");
  localStorage.removeItem("nowaprimaryHoverColor");
  localStorage.removeItem("nowaprimaryBorderColor");
  localStorage.removeItem("nowaprimaryTransparent");
  localStorage.removeItem("nowatransparentBgImgPrimary");
  localStorage.removeItem("nowatransparentBgImgprimaryTransparent");
  window.body.classList.add("transparent-theme");
  window.body.classList.remove("light-theme");
  window.body.classList.remove("dark-theme");
  window.body?.classList.remove("bg-img1");
  window.body?.classList.remove("bg-img2");
  window.body?.classList.remove("bg-img3");
  window.body?.classList.remove("bg-img4");

  document.querySelector("body").classList.remove("light-header");
  document.querySelector("body").classList.remove("dark-header");
  document.querySelector("body").classList.remove("color-header");
  document.querySelector("body").classList.remove("gradient-header");
  document.querySelector("body").classList.remove("light-menu");
  document.querySelector("body").classList.remove("dark-menu");
  document.querySelector("body").classList.remove("color-menu");
  document.querySelector("body").classList.remove("gradient-menu");
  $("#myonoffswitchTransparent").prop("checked", true);
  checkOptions();
  names();

  localStorage.setItem("nowatransparentMode", true);
  localStorage.removeItem("nowalightMode");
  localStorage.removeItem("nowadarkMode");
}

function transparentBgImgPrimaryColor() {
  "use strict";
  $("#myonoffswitch3").prop("checked", false);
  $("#myonoffswitch6").prop("checked", false);
  $("#myonoffswitch5").prop("checked", false);
  $("#myonoffswitch8").prop("checked", false);
  var userColor = document.getElementById(
    "transparentBgImgPrimaryColorID"
  ).value;
  localStorage.setItem("nowatransparentBgImgPrimary", userColor);
  localStorage.setItem(
    "nowatransparentBgImgprimaryTransparent",
    userColor + 20
  );
  if (
    window.body?.classList.contains("bg-img1") == false &&
    window.body?.classList.contains("bg-img2") == false &&
    window.body?.classList.contains("bg-img3") == false &&
    window.body?.classList.contains("bg-img4") == false
  ) {
    window.body?.classList.add("bg-img1");
    localStorage.setItem("nowaBgImage", "bg-img1");
  }
  // removing light theme data
  localStorage.removeItem("nowadarkPrimary");
  localStorage.removeItem("nowaprimaryColor");
  localStorage.removeItem("nowaprimaryHoverColor");
  localStorage.removeItem("nowaprimaryBorderColor");
  localStorage.removeItem("nowaprimaryTransparent");
  localStorage.removeItem("nowadarkprimaryTransparent");
  localStorage.removeItem("nowatransparentPrimary");
  localStorage.removeItem("nowatransparentprimaryTransparent");
  window.body.classList.add("transparent-theme");
  window.body?.classList.remove("light-theme");
  window.body?.classList.remove("dark-theme");

  document.querySelector("body").classList.remove("light-header");
  document.querySelector("body").classList.remove("dark-header");
  document.querySelector("body").classList.remove("color-header");
  document.querySelector("body").classList.remove("gradient-header");
  document.querySelector("body").classList.remove("light-menu");
  document.querySelector("body").classList.remove("dark-menu");
  document.querySelector("body").classList.remove("color-menu");
  document.querySelector("body").classList.remove("gradient-menu");
  $("#myonoffswitchTransparent").prop("checked", true);
  checkOptions();
  names();

  localStorage.setItem("nowatransparentMode", true);
  localStorage.removeItem("nowalightMode");
  localStorage.removeItem("nowadarkMode");
}

function transparentBgColor() {
  "use strict";
  $("#myonoffswitch3").prop("checked", false);
  $("#myonoffswitch6").prop("checked", false);
  $("#myonoffswitch5").prop("checked", false);
  $("#myonoffswitch8").prop("checked", false);
  var userColor = document.getElementById("transparentBgColorID").value;
  localStorage.setItem("nowatransparentBgColor", userColor);
  localStorage.setItem("nowatransparentThemeColor", userColor + 95);
  localStorage.setItem("nowatransparentprimaryTransparent", userColor + 20);
  localStorage.removeItem("nowatransparentBgImgPrimary");
  localStorage.removeItem("nowatransparentBgImgprimaryTransparent");

  // removing light theme data
  localStorage.removeItem("nowadarkPrimary");
  localStorage.removeItem("nowaprimaryColor");
  localStorage.removeItem("nowaprimaryHoverColor");
  localStorage.removeItem("nowaprimaryBorderColor");
  localStorage.removeItem("nowaprimaryTransparent");
  localStorage.removeItem("nowaBgImage");
  window.body.classList.add("transparent-theme");
  window.body.classList.remove("light-theme");
  window.body.classList.remove("dark-theme");
  window.body?.classList.remove("bg-img1");
  window.body?.classList.remove("bg-img2");
  window.body?.classList.remove("bg-img3");
  window.body?.classList.remove("bg-img4");

  document.querySelector("body").classList.remove("light-header");
  document.querySelector("body").classList.remove("dark-header");
  document.querySelector("body").classList.remove("color-header");
  document.querySelector("body").classList.remove("gradient-header");
  document.querySelector("body").classList.remove("light-menu");
  document.querySelector("body").classList.remove("dark-menu");
  document.querySelector("body").classList.remove("color-menu");
  document.querySelector("body").classList.remove("gradient-menu");
  $("#myonoffswitchTransparent").prop("checked", true);
  checkOptions();

  localStorage.setItem("nowatransparentMode", true);
  localStorage.removeItem("nowalightMode");
  localStorage.removeItem("nowadarkMode");
}

function bgImage(e) {
  "use strict";

  $("#myonoffswitch3").prop("checked", false);
  $("#myonoffswitch6").prop("checked", false);
  $("#myonoffswitch5").prop("checked", false);
  $("#myonoffswitch8").prop("checked", false);
  let imgID = e.getAttribute("class");
  localStorage.setItem("nowaBgImage", imgID);

  // removing light theme data
  localStorage.removeItem("nowadarkPrimary");
  localStorage.removeItem("nowaprimaryColor");
  localStorage.removeItem("nowatransparentBgColor");
  localStorage.removeItem("nowatransparentThemeColor");
  localStorage.removeItem("nowatransparentprimaryTransparent");
  window.body.classList.add("transparent-theme");
  window.body?.classList.remove("light-theme");
  window.body?.classList.remove("dark-theme");

  document.querySelector("body").classList.remove("light-header");
  document.querySelector("body").classList.remove("dark-header");
  document.querySelector("body").classList.remove("color-header");
  document.querySelector("body").classList.remove("gradient-header");
  document.querySelector("body").classList.remove("light-menu");
  document.querySelector("body").classList.remove("dark-menu");
  document.querySelector("body").classList.remove("color-menu");
  document.querySelector("body").classList.remove("gradient-menu");
  $("#myonoffswitchTransparent").prop("checked", true);
  checkOptions();

  localStorage.setItem("nowatransparentMode", true);
  localStorage.removeItem("nowalightMode");
  localStorage.removeItem("nowadarkMode");
}

function names() {
  "use strict";
  let primaryColorVal = getComputedStyle(document.documentElement)
    .getPropertyValue("--primary-bg-color")
    .trim();

  //get variable
  window.myVarVal =
    localStorage.getItem("nowaprimaryColor") ||
    localStorage.getItem("nowadarkPrimary") ||
    localStorage.getItem("nowatransparentPrimary") ||
    localStorage.getItem("nowatransparentBgImgPrimary") ||
    primaryColorVal;

  if (document.querySelector("#statistics1") !== null) {
    statistics1();
  }

  if (document.querySelector("#Viewers") !== null) {
    viewers();
  }

  if (document.querySelector(".chart-circle") !== null) {
    chartCircle();
  }

  if (document.querySelector("#statistics2") !== null) {
    statistics2();
  }

  if (document.querySelector("#budget") !== null) {
    budget();
  }

  if (document.querySelector("#Viewers1") !== null) {
    viewers1();
  }

  if (document.querySelector("#statistics3") !== null) {
    statistics3();
  }

  if (document.querySelector("#Viewers2") !== null) {
    viewers2();
  }

  let colorData = hexToRgba(window.myVarVal || primaryColorVal, 0.1);
  window.html.style.setProperty("--primary01", colorData);

  let colorData1 = hexToRgba(window.myVarVal || primaryColorVal, 0.2);
  window.html.style.setProperty("--primary02", colorData1);

  let colorData2 = hexToRgba(window.myVarVal || primaryColorVal, 0.3);
  window.html.style.setProperty("--primary03", colorData2);

  let colorData3 = hexToRgba(window.myVarVal || primaryColorVal, 0.6);
  window.html.style.setProperty("--primary06", colorData3);

  let colorData4 = hexToRgba(window.myVarVal || primaryColorVal, 0.9);
  window.html.style.setProperty("--primary09", colorData4);

  let colorData5 = hexToRgba(window.myVarVal || primaryColorVal, 0.5);
  window.html.style.setProperty("--primary05", colorData5);
}
names();
