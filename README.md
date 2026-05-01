# Restaurant AI Agent (AI Waiter) 🍔🤖

Yeh ek cross-platform (Mobile + Laptop) Flutter app hai jo restaurants ke liye AI Agent banati hai. Yeh app aapke restaurant ke incoming calls ko automatically pick karegi, customer se baat karke order legi, aur auto-bill generate karegi. 

Yeh bilkul `vapi.ai` jaisa system hai, lekin isay aap khud zero investment se setup kar sakte hain.

## 🚀 Features (Khasiyat)
- **Cross-platform UI**: Laptop aur Mobile dono pe perfectly chalti hai.
- **Live Call Dashboard**: AI jab call par customer se baat kar raha ho to aap live transcript screen par dekh sakte hain.
- **Auto Billing**: Customer ke order ke hisab se AI khud bill calculate karta hai.
- **Order Management**: Call khatam hone ke baad order direct dashboard mein show hota hai.

---

## 🛠️ Zero Investment Tech Stack (Kaise Banayein?)

Aap Pakistan mein hain aur bina investment shuru karna chahte hain, isliye hum aisi tools use karenge jinki **Free Tier** available hai:

1. **Frontend (App & Dashboard)**: **Flutter** (Jo is repository mein likha gaya hai). Yeh free hai aur 1 code base se Android, iOS aur Web/Laptop pe chalta hai.
2. **Database & Backend**: **Supabase**. Yeh bilkul free tier deta hai jahan aap apna menu aur orders save kar sakte hain.
3. **AI Brain (LLM)**: **Google Gemini API** ya **OpenAI (ChatGPT)**. Google Gemini 1.5 Flash ki free tier bohat achi hai text processing aur prompt samajhne ke liye.
4. **Voice & Calling**: 
   - Option A (Phone number): **Twilio** (Sign up pe free trial credits milte hain calls receive karne ke liye).
   - Option B (Internet Calling - 100% Free): Aap app ke andar WebRTC use karke "Call AI" ka button de sakte hain, is se koi SIM ya number nahi chahiye hoga, internet se call hogi.
5. **Speech to Text & Text to Speech**: **Deepgram** (Bohat sasta aur fast hai, free credits deta hai naye accounts ko) ya OpenAI Whisper.

### Architecture Flow (Kaam Kaise Karega?)
`Customer Call ➡️ Twilio/WebRTC ➡️ Deepgram (Voice to Text) ➡️ Gemini/ChatGPT (Order Samajhna) ➡️ Deepgram (Text to Voice) ➡️ Customer sunega`
Sath hi AI Backend **Supabase** me direct order aur bill ka record dal dega jo Flutter app me live show hoga.

---

## 💻 Setup & Run Instructions

Is app ko apne laptop pe chalane ke liye yeh steps follow karein:

1. Apne laptop me **Flutter SDK** install karein.
2. Is project ke folder me terminal open karein aur run karein:
   ```bash
   flutter pub get
   ```
3. App ko laptop (Chrome/Edge/Windows) par run karne ke liye:
   ```bash
   flutter run -d chrome
   ```
   (Ya mobile attach karke run karein).

## 💰 Earning Ka Idea (Business Model)
Aap is software ko mukhtalif local restaurants aur fast food walo ko as a "Service" (SaaS) bech sakte hain. Shuru mein free trial dein, jab unka time bachega aur order accurately liye jayenge to aap unse monthly subscription fee charge kar sakte hain.

---

## CouldAI

Yeh app **CouldAI** ke zariye generate ki gayi hai. CouldAI ek AI app builder hai jo cross-platform (iOS, Android, Web, Desktop) apps banane mein madad karta hai. Aapke idea (prompt) ko samajh kar yeh autonomous AI agents ke zariye production-ready apps architect, code, test aur deploy kar sakta hai.
Mazeed maloomat ke liye visit karein: [CouldAI](https://could.ai)