package com.example.cocovision

import android.os.Bundle
import android.os.Process
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import java.io.BufferedReader
import java.io.FileReader
import java.io.IOException

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.cpu_usage"  // Define the method channel name

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Set up the method channel
        MethodChannel(flutterEngine!!.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getPeakCpuUsage") {
                // Implement the method to get CPU usage
                val peakCpuUsage = getCpuUsage()  // Get the CPU usage
                result.success(peakCpuUsage)  // Return the CPU usage to Flutter
            } else {
                result.notImplemented()  // Return an error if the method is not implemented
            }
        }
    }

    // Method to get CPU usage using /proc/stat
    private fun getCpuUsage(): String {
        try {
            // Read the first line of /proc/stat which contains CPU stats
            val reader = BufferedReader(FileReader("/proc/stat"))
            val line = reader.readLine()
            reader.close()

            // Split the line into fields
            val fields = line.split(" ")

            // The CPU usage stats are in the following order:
            // user, nice, system, idle, iowait, irq, softirq, steal, guest, guest_nice

            // Get the total CPU time and the idle CPU time
            val userTime = fields[2].toLong()
            val systemTime = fields[4].toLong()
            val idleTime = fields[5].toLong()

            // Total time is the sum of all times except idle
            val totalTime = fields.drop(2).map { it.toLong() }.sum()
            val usedTime = totalTime - idleTime

            // Calculate CPU usage as a percentage
            val cpuUsage = (usedTime.toDouble() / totalTime.toDouble()) * 100
            return String.format("%.2f", cpuUsage) + "%"  // Return as a percentage
        } catch (e: IOException) {
            e.printStackTrace()
            return "Error"  // Return error if something goes wrong
        }
    }
}
