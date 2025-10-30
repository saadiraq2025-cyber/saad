// تكسي العراق الشامل - إدارة المستخدمين والدخول
import { initializeApp } from "https://www.gstatic.com/firebasejs/11.0.1/firebase-app.js";
import { getDatabase, ref, set, get, child } from "https://www.gstatic.com/firebasejs/11.0.1/firebase-database.js";

const firebaseConfig = {
  apiKey: "AIzaSyBZy7GTKn62CqeXAgm2fLrXI67P4Lc4Q3M",
  authDomain: "taxi-15314.firebaseapp.com",
  databaseURL: "https://taxi-15314-default-rtdb.firebaseio.com/",
  projectId: "taxi-15314",
};
const app = initializeApp(firebaseConfig);
const db = getDatabase(app);

window.showRegister = function() {
  document.getElementById("loginBox").style.display = "none";
  document.getElementById("registerBox").style.display = "block";
};
window.showLogin = function() {
  document.getElementById("registerBox").style.display = "none";
  document.getElementById("loginBox").style.display = "block";
};

// 🔹 إنشاء حساب جديد
window.register = function() {
  const phone = document.getElementById("regPhone").value.trim();
  const password = document.getElementById("regPassword").value.trim();
  const type = document.getElementById("regType").value;

  if (!phone || !password) { alert("الرجاء إدخال رقم الهاتف وكلمة المرور"); return; }

  const userRef = ref(db, "users/" + phone);
  set(userRef, { phone, password, type, createdAt: new Date().toISOString() })
    .then(() => {
      localStorage.setItem("phone", phone);
      localStorage.setItem("userType", type);
      alert("✅ تم إنشاء الحساب بنجاح!");
      if (type === "rider") window.location.href = "rider.html";
      else if (type === "driver") window.location.href = "driver.html";
    })
    .catch(() => alert("❌ حدث خطأ أثناء إنشاء الحساب"));
};

// 🔹 تسجيل الدخول
window.login = function() {
  const phone = document.getElementById("loginPhone").value.trim();
  const password = document.getElementById("loginPassword").value.trim();
  if (!phone || !password) { alert("الرجاء إدخال رقم الهاتف وكلمة المرور"); return; }

  const dbRef = ref(db);
  get(child(dbRef, "users/" + phone)).then((snapshot) => {
    if (snapshot.exists()) {
      const data = snapshot.val();
      if (data.password === password) {
        if (data.banned) { alert("🚫 هذا الحساب محظور من قبل الإدارة"); return; }
        localStorage.setItem("phone", phone);
        localStorage.setItem("userType", data.type);
        alert("✅ تم تسجيل الدخول بنجاح!");
        if (data.type === "rider") window.location.href = "rider.html";
        else if (data.type === "driver") window.location.href = "driver.html";
        else alert("نوع الحساب غير معروف!");
      } else alert("❌ كلمة المرور غير صحيحة");
    } else alert("❌ الحساب غير موجود");
  });
};
