import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Health and Medical Services',
        'subcategories': [
          {
            'title': 'Primary and Specialty Care',
            'items': [
              'General Consultations with Doctors',
              'Specialty Consultations (e.g., dermatology, diabetes management, hypertension)',
              'Diagnostic Tests at Home'
            ]
          },
          {
            'title': 'Mental Health Services',
            'items': [
              'Therapy Sessions',
              'Consultations with Psychiatrists'
            ]
          },
          {
            'title': 'Telehealth Services',
            'items': [
              'Video Consultations',
              'Appointment Booking',
              'Medicine Delivery'
            ]
          },
          {
            'title': 'Wellness Programs',
            'items': [
              'Nutrition Advice',
              'Weight Management',
              'Smoking Cessation',
              'Back/Joint Care',
              'Health Plans Subscription'
            ]
          },
        ]
      },
      {
        'title': 'Event Services',
        'subcategories': [
          {
            'title': 'Event Planning and Execution',
            'items': [
              'Event Planning',
              'Photography',
              'Catering',
              'Entertainment'
            ]
          },
          {
            'title': 'Event Decorators',
            'items': ['Professional Decoration Services']
          }
        ]
      },
      {
        'title': 'Pet Services',
        'subcategories': [
          {
            'title': 'Pet Care',
            'items': [
              'Pet Sitting',
              'Dog Walking',
              'Pet Grooming'
            ]
          },
          {
            'title': 'Pet Transportation',
            'items': ['Safe Transport for Pets During Travel']
          }
        ]
      },
      {
        'title': 'Food and Cooking Services',
        'subcategories': [
          {
            'title': 'Personal Chef',
            'items': ['Hiring Chefs to Cook Meals at Home']
          },
          {
            'title': 'Cooking Classes',
            'items': [
              'In-home Cooking Lessons',
              'Culinary Workshops'
            ]
          },
          {
            'title': 'Meal Prep Services',
            'items': [
              'Weekly Meal Plans',
              'Bulk Cooking'
            ]
          }
        ]
      },
      {
        'title': 'Storage Services',
        'subcategories': [
          {
            'title': 'Storage Solutions',
            'items': [
              'Providing Storage Units',
              'Portable Storage Containers'
            ]
          },
          {
            'title': 'Packing and Unpacking',
            'items': [
              'Professional Packing Services',
              'Unpacking Services'
            ]
          },
          {
            'title': 'Inventory Management',
            'items': ['Cataloging Stored Items']
          }
        ]
      },
      {
        'title': 'Moving Services',
        'subcategories': [
          {
            'title': 'General Moving Services',
            'items': [
              'Help with Moving',
              'Packing',
              'Unpacking'
            ]
          },
          {
            'title': 'Long-Distance Moving',
            'items': [
              'Interstate Moving Assistance',
              'International Moving Assistance'
            ]
          },
          {
            'title': 'Furniture Disassembly/Assembly',
            'items': ['Taking Apart and Assembling Furniture']
          },
          {
            'title': 'Storage for Moving',
            'items': ['Temporary Storage Solutions']
          }
        ]
      },
      {
        'title': 'Travel and Transportation Services',
        'subcategories': [
          {
            'title': 'Travel Planning',
            'items': [
              'Customized Travel Itineraries',
              'Booking Services',
              'Travel Advice'
            ]
          },
          {
            'title': 'Airport Transportation',
            'items': ['Shuttle Services to/from Airports']
          },
          {
            'title': 'Elderly Care',
            'items': [
              'Assistance with Daily Activities',
              'Companionship',
              'Healthcare Services'
            ]
          }
        ]
      },
      {
        'title': 'Tutoring and Education',
        'subcategories': [
          {
            'title': 'Tutoring Services',
            'items': [
              'In-home Tutoring',
              'Online Tutoring'
            ]
          }
        ]
      },
      {
        'title': 'Tech Support',
        'subcategories': [
          {
            'title': 'Tech Support Services',
            'items': [
              'Device Setup',
              'Troubleshooting Issues',
              'Software Installations'
            ]
          }
        ]
      },
      {
        'title': 'Home Security Installation',
        'subcategories': [
          {
            'title': 'Home Security Services',
            'items': [
              'Setting Up Security Systems',
              'Installing Cameras'
            ]
          }
        ]
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            children: [
              ExpansionTile(
                leading: const Icon(Icons.category, color: Colors.blue),
                title: Text(
                  category['title']! as String,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: (category['subcategories'] as List).map((subcategory) {
                  return ExpansionTile(
                    leading: const Icon(Icons.subdirectory_arrow_right, color: Colors.green),
                    title: Text(subcategory['title']! as String),
                    children: (subcategory['items'] as List).map((item) {
                      return ListTile(
                        leading: const Icon(Icons.arrow_right, color: Colors.orange),
                        title: Text(item as String),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Selected: $item')),
                          );
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
              const Divider(), // Adds visual separation between categories
            ],
          );
        },
      ),
    );
  }
}
