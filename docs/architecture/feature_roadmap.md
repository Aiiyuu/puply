# Feature Roadmap Puply.dog

## 1. Landing Page (Hero)
* **Value Proposition**: High-level overview explaining Puply as a social discovery platform for dogs.
* **Call to Action (CTA)**: Prominent, dedicated buttons for Sign Up and Login.
* **Feature Highlights**: Scrollable sections detailing the Swipe, Match, and Real-time Chat ecosystems.

---

## 2. Authorization
* **Registration/Login**: Separate dedicated pages for Email + Password.
* **OAuth Integration**: "Continue with Google" and "Continue with Facebook" buttons.
* **Password Recovery**: Secure flow for "Forgot Password" using email-based reset tokens.

> [!IMPORTANT]  
> All authorization steps must be standalone routes. Avoid using modals for the core auth flow to ensure deep-linking and browser history work correctly.

---

## 3. Onboarding Flow

### 3.1 Profile Construction
| Field | Status | Type | Gemini Suggestion |
| :--- | :--- | :--- | :--- |
| **Display Name** | Required | Text | |
| **Age** | Optional | Number | |
| **Avatar** | Optional | Image Upload | |
| **Description** | Optional | Textarea | |
| **Breed** | Optional | Select/Search | |
| **Orientation** | Optional | Select | |
| **Energy Level** | New | 1-5 Scale | Useful for matching active vs. lazy dogs. |
| **Size** | New | Enum | Toy, Small, Medium, Large, Giant. |
| **Social Temper** | New | Tags | "Good with cats", "Prefers solo play". |

### 3.2 Interest Management
* **Tag System**: Browseable and searchable global list of interests.
* **Custom Entry**: Users can define new tags which are persisted to the database.

| Category | Example Tags |
| :--- | :--- |
| **Activities** | Hiking, Fetch, Swimming, Agility, Frisbee |
| **Training** | Service Dog, Puppy School, Basic Commands |
| **Dietary** | Raw Food, Grain-Free, Treat Enthusiast |

### 3.3 Discovery Preferences (Filters)
* **Core Filters**: Age Range, Preferred Breeds, Orientations.
* **Advanced Filters**: 
    * **Distance**: Geolocation radius (0-100 miles).
    * **Activity Match**: Filter by Energy Level (1-5).
    * **Recency**: Only show dogs active in the last 24-48 hours.

### 3.4 Geographic & Analytics
* **Interactive Map**: SVG-based USA map for state-level selection.
* **Heatmap**: States shaded in darker hues based on dog population density.
* **Attribution**: "How did you hear about us?" form for marketing statistics.

---

## 4. Profile Management
* **View/Edit**: Toggle-based interface.
* **Media Gallery**: Support for multiple photos with Drag-and-Drop (DND) reordering.
* **Statistics**: Private dashboard using **Chart.js** to show profile views and swipe trends.

> [!NOTE]  
> The DND gallery order should be saved to the database immediately upon the "End" event of the drag action.

---

## 5. Settings and Privacy

### 5.1 Organizational Tabs
| Tab | Focus Area |
| :--- | :--- |
| **Account** | Security, Password, Email, Data Export |
| **Privacy** | Visibility, Status, Last Seen, Blacklist |
| **Notifications** | Email alerts, In-App push toggles |
| **Preferences** | Chat receipts, NSFW filters |
| **Danger Zone** | Account Deactivation, Delete All Data |

### 5.2 Privacy Controls
* **Profile Visibility**: 
    * **Public**: Everyone in Discovery.
    * **Mutuals**: Only people you have both liked.
    * **Incognito**: Only people you have liked can see you.
* **Status Visibility**: Online/Offline/Always Hidden.
* **Last Seen**: Toggle timestamp (Configurable globally or per-user).
* **Chat Receipts**: Control for "Read" and "Retrieved" marks.

> [!CAUTION]
> Changing "Last Seen" to hidden should also prevent the user from seeing other users' "Last Seen" statuses (Reciprocity principle).

---

## 6. Discovery Interface
* **Swipe Deck**: Card-based interface for rapid evaluation.
* **Quick View**: Modal with summary and gallery (5-10 images).
* **Smart Sorting**: Sort by "Newest Members" or "Closest to Me."

---

## 7. Messaging System (WebSockets)

### 7.1 Real-time Metadata
* **User Status**: Live Online/Offline indicators.
* **Message Status**: Retrieved (Delivered) vs. Read.
* **Manual Control**: "Mark as Read" functionality.

### 7.2 Content Support
| Feature | Phase | Type |
| :--- | :--- | :--- |
| **Text/Emojis** | V1 | Core |
| **Giphy Stickers** | V1 | API Integration |
| **Photos/Video** | V1 | File Upload (S3) |
| **Voice/Video Circles**| V2 | Media Streams |

### 7.3 Advanced Messaging Features
* **Message Search**: Search by keyword within a chat thread.
* **Quick Replies**: Configurable templates (e.g., "Ready for a walk?").
* **Chat Muting**: Silence specific threads without blocking.
