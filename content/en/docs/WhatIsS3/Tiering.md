---
title: "Tiering"
date: 2021-12-18
weight: 7
description: >
  OpEx|Sec|Rel|Perf|Cost|Sus
          ==================
resources:
- src: "**.{png,jpg}"
  title: "Image #:counter"
  params:
    byline: "Diagrams: Ric Harvey / CC-BY-SA"
---

File storage puts data in folder-like structures and a hierarchical file. The file is stored as one file, one chunk of data and is not broken down into smaller blocks. Folders can be nested and in order to retrieve the file, the entire directory path is required to get to the data. Lots of NAS systems you buy at-home use this type of storage because it’s cheaper than block storage. It’s very good for lots of small files and can potentially scale to millions of files. The file system is generally local, as in one physical location. File storage also stores limited metadata with the file, typically, date created, file, and path.
If you think of file storage like a multi-story car park, you drive in and park in a spot. In order to get your car back, you need to remember the car park location, the floor you were parked on, and the space in which you left the car. All of those things are needed to successfully get your car back.

![File and Folder Hierarical Structure](../file-storage.png "Fig 1. File and Folder structure")
