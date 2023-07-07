// ignore_for_file: avoid_dynamic_calls

import 'package:intl/intl.dart';
import 'package:tennis_court_scheduling/weather/weather.dart';
import 'dart:convert';

class WeatherRepository {
  WeatherRepository({required this.dataProvider});

  final WeatherDataProvider dataProvider;

  Future<WeatherModel?> getData(DateTime date) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var data = await dataProvider.readBox(formattedDate);

    /// If [data] is null fetch data from the [dataProvider]
    data ??= await _fetchAndWriteBox();

    try {
      return data.firstWhere(
        (item) =>
            DateTime(item.date.year, item.date.month, item.date.day) ==
            DateTime(date.year, date.month, date.day),
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<WeatherModel>> _fetchAndWriteBox() async {
    /// Clean the box because old data is not needed
    await dataProvider.clearBox();

    /// Make the request to the API and get the rawData
    // final rawData = await dataProvider.fetchForecastData();
    final rawData = json.decode("""
{
  "Headline": {
    "EffectiveDate": "2023-07-07T07:30:00-04:00",
    "EffectiveEpochDate": 1688729400,
    "Severity": 5,
    "Text": "A thunderstorm tomorrow",
    "Category": "thunderstorm",
    "EndDate": "2023-07-07T19:30:00-04:00",
    "EndEpochDate": 1688772600,
    "MobileLink": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?unit=c&lang=en-us",
    "Link": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?unit=c&lang=en-us"
  },
  "DailyForecasts": [
    {
      "Date": "2023-07-06T07:00:00-04:00",
      "EpochDate": 1688641200,
      "Sun": {
        "Rise": "2023-07-06T06:11:00-04:00",
        "EpochRise": 1688638260,
        "Set": "2023-07-06T18:54:00-04:00",
        "EpochSet": 1688684040
      },
      "Moon": {
        "Rise": "2023-07-06T22:14:00-04:00",
        "EpochRise": 1688696040,
        "Set": "2023-07-07T10:20:00-04:00",
        "EpochSet": 1688739600,
        "Phase": "WaningGibbous",
        "Age": 18
      },
      "Temperature": {
        "Minimum": {
          "Value": 19.6,
          "Unit": "C",
          "UnitType": 17
        },
        "Maximum": {
          "Value": 29.9,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "RealFeelTemperature": {
        "Minimum": {
          "Value": 19.2,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Pleasant"
        },
        "Maximum": {
          "Value": 36.8,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Hot"
        }
      },
      "RealFeelTemperatureShade": {
        "Minimum": {
          "Value": 19.2,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Pleasant"
        },
        "Maximum": {
          "Value": 30.4,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Very Warm"
        }
      },
      "HoursOfSun": 7,
      "DegreeDaySummary": {
        "Heating": {
          "Value": 0,
          "Unit": "C",
          "UnitType": 17
        },
        "Cooling": {
          "Value": 7,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "AirAndPollen": [
        {
          "Name": "AirQuality",
          "Value": 0,
          "Category": "Good",
          "CategoryValue": 1,
          "Type": "Ozone"
        },
        {
          "Name": "Grass",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Mold",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Ragweed",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Tree",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "UVIndex",
          "Value": 12,
          "Category": "Extreme",
          "CategoryValue": 5
        }
      ],
      "Day": {
        "Icon": 4,
        "IconPhrase": "Intermittent clouds",
        "HasPrecipitation": false,
        "ShortPhrase": "Clouds giving way to some sun",
        "LongPhrase": "Clouds giving way to some sun",
        "PrecipitationProbability": 6,
        "ThunderstormProbability": 0,
        "RainProbability": 6,
        "SnowProbability": 0,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 7.4,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 155,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 22.2,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 145,
            "Localized": "SE",
            "English": "SE"
          }
        },
        "TotalLiquid": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 0,
        "HoursOfRain": 0,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 42,
        "Evapotranspiration": {
          "Value": 4.1,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 6884.8,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Night": {
        "Icon": 38,
        "IconPhrase": "Mostly cloudy",
        "HasPrecipitation": false,
        "ShortPhrase": "Increasing clouds",
        "LongPhrase": "Increasing cloudiness this evening followed by low clouds",
        "PrecipitationProbability": 7,
        "ThunderstormProbability": 0,
        "RainProbability": 7,
        "SnowProbability": 0,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 5.6,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 157,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 18.5,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 157,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "TotalLiquid": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 0,
        "HoursOfRain": 0,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 73,
        "Evapotranspiration": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 33,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Sources": ["AccuWeather"],
      "MobileLink": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?day=1&unit=c&lang=en-us",
      "Link": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?day=1&unit=c&lang=en-us"
    },
    {
      "Date": "2023-07-07T07:00:00-04:00",
      "EpochDate": 1688727600,
      "Sun": {
        "Rise": "2023-07-07T06:11:00-04:00",
        "EpochRise": 1688724660,
        "Set": "2023-07-07T18:54:00-04:00",
        "EpochSet": 1688770440
      },
      "Moon": {
        "Rise": "2023-07-07T22:59:00-04:00",
        "EpochRise": 1688785140,
        "Set": "2023-07-08T11:15:00-04:00",
        "EpochSet": 1688829300,
        "Phase": "WaningGibbous",
        "Age": 19
      },
      "Temperature": {
        "Minimum": {
          "Value": 20.2,
          "Unit": "C",
          "UnitType": 17
        },
        "Maximum": {
          "Value": 30.6,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "RealFeelTemperature": {
        "Minimum": {
          "Value": 20.7,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Pleasant"
        },
        "Maximum": {
          "Value": 38,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Very Hot"
        }
      },
      "RealFeelTemperatureShade": {
        "Minimum": {
          "Value": 20.7,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Pleasant"
        },
        "Maximum": {
          "Value": 31.5,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Hot"
        }
      },
      "HoursOfSun": 4.8,
      "DegreeDaySummary": {
        "Heating": {
          "Value": 0,
          "Unit": "C",
          "UnitType": 17
        },
        "Cooling": {
          "Value": 7,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "AirAndPollen": [
        {
          "Name": "AirQuality",
          "Value": 0,
          "Category": "Good",
          "CategoryValue": 1,
          "Type": "Ozone"
        },
        {
          "Name": "Grass",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Mold",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Ragweed",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Tree",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "UVIndex",
          "Value": 12,
          "Category": "Extreme",
          "CategoryValue": 5
        }
      ],
      "Day": {
        "Icon": 15,
        "IconPhrase": "Thunderstorms",
        "HasPrecipitation": true,
        "PrecipitationType": "Rain",
        "PrecipitationIntensity": "Moderate",
        "ShortPhrase": "Some rain and a thunderstorm",
        "LongPhrase": "Very warm; a thunderstorm in parts of the area in the morning followed by occasional rain and a thunderstorm in the afternoon",
        "PrecipitationProbability": 70,
        "ThunderstormProbability": 42,
        "RainProbability": 70,
        "SnowProbability": 0,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 7.4,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 154,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 18.5,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 147,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "TotalLiquid": {
          "Value": 4.7,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 4.7,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 3,
        "HoursOfRain": 3,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 74,
        "Evapotranspiration": {
          "Value": 3.3,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 5782.7,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Night": {
        "Icon": 8,
        "IconPhrase": "Dreary",
        "HasPrecipitation": false,
        "ShortPhrase": "Low clouds",
        "LongPhrase": "Low clouds",
        "PrecipitationProbability": 25,
        "ThunderstormProbability": 6,
        "RainProbability": 25,
        "SnowProbability": 0,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 5.6,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 149,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 16.7,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 152,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "TotalLiquid": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 0,
        "HoursOfRain": 0,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 97,
        "Evapotranspiration": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 25.6,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Sources": ["AccuWeather"],
      "MobileLink": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?day=2&unit=c&lang=en-us",
      "Link": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?day=2&unit=c&lang=en-us"
    },
    {
      "Date": "2023-07-08T07:00:00-04:00",
      "EpochDate": 1688814000,
      "Sun": {
        "Rise": "2023-07-08T06:11:00-04:00",
        "EpochRise": 1688811060,
        "Set": "2023-07-08T18:54:00-04:00",
        "EpochSet": 1688856840
      },
      "Moon": {
        "Rise": "2023-07-06T23:42:00-04:00",
        "EpochRise": 1688701320,
        "Set": "2023-07-06T11:15:00-04:00",
        "EpochSet": 1688656500,
        "Phase": "WaningGibbous",
        "Age": 20
      },
      "Temperature": {
        "Minimum": {
          "Value": 19.7,
          "Unit": "C",
          "UnitType": 17
        },
        "Maximum": {
          "Value": 29.9,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "RealFeelTemperature": {
        "Minimum": {
          "Value": 19.7,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Pleasant"
        },
        "Maximum": {
          "Value": 37.5,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Very Hot"
        }
      },
      "RealFeelTemperatureShade": {
        "Minimum": {
          "Value": 19.7,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Pleasant"
        },
        "Maximum": {
          "Value": 32.1,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Hot"
        }
      },
      "HoursOfSun": 4.2,
      "DegreeDaySummary": {
        "Heating": {
          "Value": 0,
          "Unit": "C",
          "UnitType": 17
        },
        "Cooling": {
          "Value": 7,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "AirAndPollen": [
        {
          "Name": "AirQuality",
          "Value": 0,
          "Category": "Good",
          "CategoryValue": 1,
          "Type": "Ozone"
        },
        {
          "Name": "Grass",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Mold",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Ragweed",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Tree",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "UVIndex",
          "Value": 11,
          "Category": "Extreme",
          "CategoryValue": 5
        }
      ],
      "Day": {
        "Icon": 15,
        "IconPhrase": "Thunderstorms",
        "HasPrecipitation": true,
        "PrecipitationType": "Rain",
        "PrecipitationIntensity": "Light",
        "ShortPhrase": "Some rain and a thunderstorm",
        "LongPhrase": "Mostly cloudy; occasional rain and a thunderstorm in the morning followed by a thunderstorm in parts of the area in the afternoon",
        "PrecipitationProbability": 69,
        "ThunderstormProbability": 41,
        "RainProbability": 69,
        "SnowProbability": 0,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 7.4,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 150,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 22.2,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 147,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "TotalLiquid": {
          "Value": 3.8,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 3.8,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 2,
        "HoursOfRain": 2,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 79,
        "Evapotranspiration": {
          "Value": 3,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 4625.8,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Night": {
        "Icon": 7,
        "IconPhrase": "Cloudy",
        "HasPrecipitation": false,
        "ShortPhrase": "Cloudy",
        "LongPhrase": "Cloudy",
        "PrecipitationProbability": 25,
        "ThunderstormProbability": 6,
        "RainProbability": 25,
        "SnowProbability": 0,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 7.4,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 149,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 18.5,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 146,
            "Localized": "SE",
            "English": "SE"
          }
        },
        "TotalLiquid": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 0,
        "HoursOfRain": 0,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 97,
        "Evapotranspiration": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 3.8,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Sources": ["AccuWeather"],
      "MobileLink": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?day=3&unit=c&lang=en-us",
      "Link": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?day=3&unit=c&lang=en-us"
    },
    {
      "Date": "2023-07-09T07:00:00-04:00",
      "EpochDate": 1688900400,
      "Sun": {
        "Rise": "2023-07-09T06:12:00-04:00",
        "EpochRise": 1688897520,
        "Set": "2023-07-09T18:54:00-04:00",
        "EpochSet": 1688943240
      },
      "Moon": {
        "Rise": null,
        "EpochRise": null,
        "Set": "2023-07-10T12:07:00-04:00",
        "EpochSet": 1689005220,
        "Phase": "Last",
        "Age": 21
      },
      "Temperature": {
        "Minimum": {
          "Value": 20.3,
          "Unit": "C",
          "UnitType": 17
        },
        "Maximum": {
          "Value": 30,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "RealFeelTemperature": {
        "Minimum": {
          "Value": 21,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Pleasant"
        },
        "Maximum": {
          "Value": 36.2,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Hot"
        }
      },
      "RealFeelTemperatureShade": {
        "Minimum": {
          "Value": 21,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Pleasant"
        },
        "Maximum": {
          "Value": 31.2,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Very Warm"
        }
      },
      "HoursOfSun": 3.3,
      "DegreeDaySummary": {
        "Heating": {
          "Value": 0,
          "Unit": "C",
          "UnitType": 17
        },
        "Cooling": {
          "Value": 7,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "AirAndPollen": [
        {
          "Name": "AirQuality",
          "Value": 0,
          "Category": "Good",
          "CategoryValue": 1,
          "Type": "Ozone"
        },
        {
          "Name": "Grass",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Mold",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Ragweed",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Tree",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "UVIndex",
          "Value": 6,
          "Category": "High",
          "CategoryValue": 3
        }
      ],
      "Day": {
        "Icon": 4,
        "IconPhrase": "Intermittent clouds",
        "HasPrecipitation": true,
        "PrecipitationType": "Rain",
        "PrecipitationIntensity": "Moderate",
        "ShortPhrase": "Warm; a stray p.m. t-storm",
        "LongPhrase": "Very warm with sun and clouds; a thunderstorm in parts of the area in the afternoon",
        "PrecipitationProbability": 46,
        "ThunderstormProbability": 28,
        "RainProbability": 46,
        "SnowProbability": 0,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 7.4,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 151,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 22.2,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 146,
            "Localized": "SE",
            "English": "SE"
          }
        },
        "TotalLiquid": {
          "Value": 3.9,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 3.9,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 1,
        "HoursOfRain": 1,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 80,
        "Evapotranspiration": {
          "Value": 2.5,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 2552.2,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Night": {
        "Icon": 38,
        "IconPhrase": "Mostly cloudy",
        "HasPrecipitation": false,
        "ShortPhrase": "Increasing clouds",
        "LongPhrase": "Increasing clouds",
        "PrecipitationProbability": 25,
        "ThunderstormProbability": 6,
        "RainProbability": 25,
        "SnowProbability": 0,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 5.6,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 150,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 16.7,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 147,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "TotalLiquid": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 0,
        "HoursOfRain": 0,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 77,
        "Evapotranspiration": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 44.7,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Sources": ["AccuWeather"],
      "MobileLink": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?day=4&unit=c&lang=en-us",
      "Link": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?day=4&unit=c&lang=en-us"
    },
    {
      "Date": "2023-07-10T07:00:00-04:00",
      "EpochDate": 1688986800,
      "Sun": {
        "Rise": "2023-07-10T06:12:00-04:00",
        "EpochRise": 1688983920,
        "Set": "2023-07-10T18:54:00-04:00",
        "EpochSet": 1689029640
      },
      "Moon": {
        "Rise": "2023-07-10T00:24:00-04:00",
        "EpochRise": 1688963040,
        "Set": "2023-07-10T12:58:00-04:00",
        "EpochSet": 1689008280,
        "Phase": "WaningCrescent",
        "Age": 22
      },
      "Temperature": {
        "Minimum": {
          "Value": 20.5,
          "Unit": "C",
          "UnitType": 17
        },
        "Maximum": {
          "Value": 29.9,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "RealFeelTemperature": {
        "Minimum": {
          "Value": 21.2,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Pleasant"
        },
        "Maximum": {
          "Value": 37.6,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Very Hot"
        }
      },
      "RealFeelTemperatureShade": {
        "Minimum": {
          "Value": 21.2,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Pleasant"
        },
        "Maximum": {
          "Value": 32.5,
          "Unit": "C",
          "UnitType": 17,
          "Phrase": "Hot"
        }
      },
      "HoursOfSun": 5.9,
      "DegreeDaySummary": {
        "Heating": {
          "Value": 0,
          "Unit": "C",
          "UnitType": 17
        },
        "Cooling": {
          "Value": 7,
          "Unit": "C",
          "UnitType": 17
        }
      },
      "AirAndPollen": [
        {
          "Name": "AirQuality",
          "Value": 0,
          "Category": "Good",
          "CategoryValue": 1,
          "Type": "Ozone"
        },
        {
          "Name": "Grass",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Mold",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Ragweed",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "Tree",
          "Value": 0,
          "Category": "Low",
          "CategoryValue": 1
        },
        {
          "Name": "UVIndex",
          "Value": 9,
          "Category": "Very High",
          "CategoryValue": 4
        }
      ],
      "Day": {
        "Icon": 14,
        "IconPhrase": "Partly sunny w/ showers",
        "HasPrecipitation": true,
        "PrecipitationType": "Rain",
        "PrecipitationIntensity": "Light",
        "ShortPhrase": "A couple of morning showers",
        "LongPhrase": "Clouds and sunshine; a couple of morning showers followed by a thunderstorm in parts of the area in the afternoon",
        "PrecipitationProbability": 65,
        "ThunderstormProbability": 39,
        "RainProbability": 65,
        "SnowProbability": 0,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 7.4,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 141,
            "Localized": "SE",
            "English": "SE"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 18.5,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 145,
            "Localized": "SE",
            "English": "SE"
          }
        },
        "TotalLiquid": {
          "Value": 2.7,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 2.7,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 2,
        "HoursOfRain": 2,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 61,
        "Evapotranspiration": {
          "Value": 3.3,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 6258.5,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Night": {
        "Icon": 38,
        "IconPhrase": "Mostly cloudy",
        "HasPrecipitation": false,
        "ShortPhrase": "Areas of low clouds",
        "LongPhrase": "Areas of low clouds",
        "PrecipitationProbability": 25,
        "ThunderstormProbability": 6,
        "RainProbability": 25,
        "SnowProbability": 0,
        "IceProbability": 0,
        "Wind": {
          "Speed": {
            "Value": 5.6,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 148,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "WindGust": {
          "Speed": {
            "Value": 16.7,
            "Unit": "km/h",
            "UnitType": 7
          },
          "Direction": {
            "Degrees": 149,
            "Localized": "SSE",
            "English": "SSE"
          }
        },
        "TotalLiquid": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Rain": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "Snow": {
          "Value": 0,
          "Unit": "cm",
          "UnitType": 4
        },
        "Ice": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "HoursOfPrecipitation": 0,
        "HoursOfRain": 0,
        "HoursOfSnow": 0,
        "HoursOfIce": 0,
        "CloudCover": 76,
        "Evapotranspiration": {
          "Value": 0,
          "Unit": "mm",
          "UnitType": 3
        },
        "SolarIrradiance": {
          "Value": 62.5,
          "Unit": "W/m²",
          "UnitType": 33
        }
      },
      "Sources": ["AccuWeather"],
      "MobileLink": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?day=5&unit=c&lang=en-us",
      "Link": "http://www.accuweather.com/en/ve/caracas/353020/daily-weather-forecast/353020?day=5&unit=c&lang=en-us"
    }
  ]
}
""");

    if (rawData == null) return [];

    final data = <WeatherModel>[];
    final rawForecasts = rawData['DailyForecasts'] as List<dynamic>? ?? [];
    for (final item in rawForecasts) {
      final date = DateTime.parse(item['Date'] as String);
      final dayProbability = item['Day']['PrecipitationProbability'] as int;
      final nightProbability = item['Night']['PrecipitationProbability'] as int;

      data.add(
        WeatherModel(
            date: date,
            precipitationProbabilityDay: dayProbability,
            precipitationProbabilityNight: nightProbability),
      );
    }

    return data;
  }
}
