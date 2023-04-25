package com.vietxcode.dailyquest

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform