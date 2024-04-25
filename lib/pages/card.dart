import 'package:flutter/material.dart';
import 'package:srv/model/model.dart';

Container card(BuildContext context, Batch batch) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color.fromARGB(47, 157, 157, 157),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          batch.name,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, letterSpacing: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Text(
                batch.branchName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "ID : ${batch.uniqueId.substring(0, 12)}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 99, 99, 99),
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            "36 Days (${batch.startDate} to ${batch.endDate})",
            style: const TextStyle(
              fontSize: 17,
              color: Color.fromARGB(255, 99, 99, 99),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            "CSP : ${batch.branchName}",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/calendar.png",
                    height: 30,
                  ),
                  const Text(
                    "Attendance",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/approve.png",
                    height: 30,
                  ),
                  const Text(
                    "QF Work",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/student.png",
                    height: 30,
                  ),
                  const Text(
                    "Student View",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/delivery.png",
                    height: 30,
                  ),
                  const Text(
                    "Assessment",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
