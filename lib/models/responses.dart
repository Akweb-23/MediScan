// lib/responses.dart

// A Map containing keywords (lowercase) and their corresponding healthcare response.
const Map<String, String> healthcareResponses = {
  // --- Common Health Inquiries ---
  "fever": "A fever is usually a sign your body is fighting an infection. Rest, stay hydrated, and consider over-the-counter fever reducers like paracetamol. If fever exceeds 103°F (39.4°C) or lasts more than 3 days, please consult a doctor.",
  "headache": "For a common headache, try resting, drinking water, and taking ibuprofen or acetaminophen. If the headache is sudden, severe, or accompanied by blurred vision or stiffness, seek immediate medical attention.",
  "cold": "A common cold requires rest and fluids. Symptoms usually clear up within a week. Wash your hands frequently to avoid spreading it.",
  "sore throat": "Gargle with warm salt water, drink warm liquids like tea with honey, and rest your voice. If swallowing becomes extremely painful or you see white spots, consult a physician.",
  "stomach ache": "For mild stomach discomfort, try sipping on clear fluids or ginger ale, and avoid solid food for a few hours. If the pain is sharp, located in one specific area, or bloody stool is present, seek care.",

  // --- COVID/Infection Related ---
  "covid": "If you suspect COVID-19, isolate yourself, wear a mask, and get tested. Monitor your oxygen levels and contact a local health hotline for advice on recovery and treatment.",
  "vomit": "If you are vomiting, focus on small sips of clear liquids (like electrolyte solution) to prevent dehydration. Avoid dairy and heavy foods. Consult a doctor if vomiting persists for over 24 hours.",

  // --- Basic Information / App Help ---
  "app help": "Mediscan is designed to provide quick, general health advice. It is NOT a substitute for professional medical diagnosis or treatment.",
  "hello": "Hello! I am Mediscan, your simple healthcare assistant. What question do you have about your symptoms?",
  "hey":"hii are you fine!"
  ""
};

// Function to find the best matching response based on keywords
String getRuleBasedResponse(String message) {
  final cleanMessage = message.toLowerCase();

  // Prioritize exact keyword matches (even within a sentence)
  for (final keyword in healthcareResponses.keys) {
    if (cleanMessage.contains(keyword)) {
      return healthcareResponses[keyword]!;
    }
  }

  // If no match is found
  return "I'm sorry, I don't have a specific rule-based response for that. Please remember I provide general advice and cannot diagnose or treat medical conditions. Always consult a healthcare professional for specific concerns.";
}