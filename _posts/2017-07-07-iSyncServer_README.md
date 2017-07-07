---
layout: post
title:  "iSyncServer: The file management server"
author: Terry
date:   2017-07-07 15:24
categories: python
tags: iPrivate 文件管理 同步 云盘 iSyncServer
---

* content
{:toc}

[中文说明](http://icc.one/2017/07/05/iSyncServer%E4%BB%8B%E7%BB%8D/)

# Introduction
With [Raspberry Pi](https://www.raspberrypi.org/), through the HTTP protocol on the mobile hard disk to operate. Scan the specified file path and write to the database, providing a series of API interfaces to add or delete or modify or search.Family members easy access to their media files






**Server** need install:pyenv, python3, flask. If you need to generate thumbnails of media files, get the media file information, you need to install: ffmpeg, Pillow

**Client** need to implement the following API interfaces as needed.Has provided the iOS client: [iPrivate](https://itunes.apple.com/us/app/iprivate-protect-your-privacy-photo-video/id992360900?l=zh&ls=1&mt=8)

Take a picture to see the effect
![](/files/20170707_iSyncServer1.png)
On the left is the effect on the iphone, the right is in the raspberry side of the effect

Let's take a look at my video, [click open](https://v.qq.com/x/page/x0522gkcfwr.html)
<iframe frameborder="0" width="640" height="498" src="https://v.qq.com/iframe/player.html?vid=x0522gkcfwr&tiny=0&auto=0" allowfullscreen></iframe>

# installation

**iSyncServer source** is hosted on [github](https://github.com/jxd524/iSyncServer) and [coding](https://coding.net/u/jxd524/p/iSyncServer/git)

### Install the server on the Raspberry Pi

Recommended download[RASPBIAN LITE](https://www.raspberrypi.org/downloads/raspbian/)


Use the following shell script to install automatically( the Script only test on Raspberry pi lite)
The script will automatically update the operating system and install the software: `git, ffmpeg, pyenv, python 3.5.2, pyenv-virtual of iSyncServerEnv3.5.2, Pillow, Flask`

```shell
curl "http://icc.one/files/raspberrypi/setupiSyncServer.sh" | bash
```

### Install the server on other operating systems

1. Install **git**
2. Install **ffmpeg**(Optional operation, if not installed, iSyncServer can not generate video thumbnails)
3. Install **pyenv**, **pyenv-virtualenv**.[help of pyenv](https://github.com/pyenv) and [help of pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)
4. Used pyenv create python 3.5.2 virtual: **iSyncServerEnv3.5.2**
5. Install [Pillow](https://pillow.readthedocs.io/en/latest/installation.html), [Flask](http://flask.pocoo.org/docs/0.12/installation/) in the virtual environment **iSyncServerEnv3.5.2**
6. Copy the **iSyncServer Source code** to local:**~/iSyncServer** .
7. Config **scanConfig.json**. 
8. Config **appConfigs.json**. you can create it with a similar code: `python configs.py --thumbPath=xxx`
9. Run **app.py** in the virtual environment **iSyncServerEnv3.5.2**

### Install the client on iOS

Install [iPrivate](https://itunes.apple.com/us/app/iprivate-protect-your-privacy-photo-video/id992360900?l=zh&ls=1&mt=8)
Open the app and go to remote ui then input server addr. like **http://192.168.1.188:5000**


# App Configuration File

Create a configuration file named **appConfigs.json** in the root directory. It will affect the entire server. If there is no configuration file, the default value is used

* **logFileName**: log file path. Default: **./building/appLog.log**
* **thumbPath**: The root path when the thumbnail is generated. Default **./building/thumbs**
* **defaultUserPath**: The default user path is only required when creating a user, but this user does not have a directory. Default: **./building/users**
* **shareUrlThreshold**: Share the maximum number of URLs. Default: 1000,
* **shareUrlTimeout**: Share the maximum cache time for the URL. Default: 1800. unit:second
* **onlineThreshold**: The number of online extreme value, exceeds this value, it will be time-out processing. Defalt: 100
* **onlineTimeout**: Online users have no activity to keep the maximum time. Default: 3600, Unit: second

Can used **configs.py**, **configs.py** support for the following fields, as in the following example

```shell
python configs.py --onlineThreshold=500 --thumbPath=/Users/terry/work/thumbPaths
```

You can also directly edit the **appConfigs.json** file under the source root directory. (If it does not exist, then directly created), the following example

```json
{
    "onlineThreshold": 500,
    "onlineTimeout": 8000,
    "thumbPath": "/Users/terry/work/thumbPaths"
}
```

<span id="scanDisk"/>

# Scan data (additional function)

In order to facilitate the processing of disk data, provided **scanDisk.py** to recursively scan the specified directory, the corresponding file and user information written to the database
The configuration file is a **JSON** file. The outer layer is an array, each object has **paths** and **users** properties

**users**: Dictionary type, definition of user **name** and **password**
**paths**: An array containing strings that defines the path information to be scanned
**mergeRootPaths**: Merge the root directory, the path has been scanned into the database to determine, to prevent too many root directory. Default: 1

In general, you only need to write the configuration file according to the requirements, and then run the `python scanDisk.py` on it. If any file changes, you only need to run the order once again to solve the problem.


See the table below for specific parameters

| param  | effect |
|----- | ---- |
| no param | Scan file according to the **scanConfig.json** file in the same directory |
| -i(fileName) | Provides the full path of the JSON file in the specified format |
| -p(scanFilePath) | Provide incremental scanning, this operation will not add users, the specified path must have been scanned before |

Execute the command example

```shell
#Scan data according to scanConfig.json in the same directory
python scanDisk.py

#Use the configuration file sd.json to scan the data
python scanDisk.py -i sd.json

#Incremental scan
python scanDisk.py -p /User/Terry/syncFiles/t2
```

Configuration file example

```json
[
    {
        "paths":["~/work/temp/sharePath", "~/Downloads"],
        "users":[
            {"name": "terry", "password": "123"},
            {"name": "terry2", "password": "333"}
        ],
        "mergeRootPaths": 1
    },
    {
        "paths":["/User/Terry/syncFiles/t1"],
        "users":[
            {"name": "terry"}
        ]
    },
    {
        "paths":["/User/Terry/syncFiles/t2"],
        "users":[
            {"name": "terry2"}
        ]
    }
]
```

# iSyncServer Source Description

If you are interested the source code, or want to develop a new iSyncServer client. You need to look it down.
Here the iSyncServer database and source, provide some of the interface to introduce

### Database Table Structure Description

Server use python built-in support for the database: sqlite3. Only four tables to record the data, the specific definition, you can refer to the source code.
1. User: user table
2. Catalog: catalog table
3. Files: file table
4. UserAssociate: **User** and **Catalog** relationship table, record the user has read and write operations of the root directory information

For the first three tables, there are [HelpInfo](#helpInfo) information, which is meaningless to the server.
Only meaningful to the client, the client can be given different needs according to the needs.

## API Interface Description

Define the request and response of the interface, if not
1. Both the request and the response interact through the **JSON** format
2. Interface need to **login** before use

### Responds Format

```json
{
    "code": 0,
    "msg": "error message.",
    "data": "Different commands have different structures"
}
```

### Type Definition

<span id="datetime">**datetime**</span>:Include the type of date and time
1970 to the present number of seconds, such as 2017-04-19 03:06:44 +0000 expressed as: 1492571204

```objc
typedef datetime int
```

<span id="orientation">**orientation**</span>: The rotation of a picture or video
In the generation of thumbnails will be used, the database records the original direction, if 0, that does not need to rotate

Corresponding relationship with UIImageOrientation in iOS

| UIImageOrientation | Rientation | Rotate |
| ------ | ------ | ------ |
| UIImageOrientationUp | 1 | No need |
| UIImageOrientationDown | 3 | 180° |
| UIImageOrientationLeft | 6 | Clockwise 90° |
| UIImageOrientationRight | 8 | Counterclockwise 90° |
| UIImageOrientationUpMirrored | 2 | horizontal flip |
| UIImageOrientationDownMirrored | 4 | Vertical flip |
| UIImageOrientationLeftMirrored | 5 | Clockwise 90° + horizontal flip |
| UIImageOrientationRightMirrored | 7 | Clockwise 90° + Vertical flip |

<span id="fileStatus">**fileStatus**</span>: File status
Whether the file exists, use the state of [scanDisk](#scanDisk): kFileStatusFromLocal
When the server needs to generate thumbnails, the corresponding field needs to be set to **kFileStatusFromLocal**, otherwise no thumbnail generation

```python
kFileStatusFromLocal        = 0 # From the local
kFileStatusBuildError       = 1 # Server can not build
kFileStatusFromUploading    = 2 # From uploading
kFileStatusFromUploaded     = 3 # From upload, and has been complete
```

Files Table Field Description:
√ Indicates possible values

| Field | Meaning | kFileStatusFromLocal | kFileStatusBuildError | kFileStatusFromUploading | kFileStatusFromUploaded |
| ------ | ------ | ------ | ------ | ------ | ------ |
| statusForOrigin | Original file | √(Already exists, generally set by [scanDisk](#scanDis)) | | √(wait upload) | √(Has been uploaded successfully) |
| statusForThumb  | Small thumbnail,[reference](#thumbnail) | √(The server auto build according to the original file) | √(Server building failed)  | √(wait upload) | √(uploaded success) |
| statusForScreen | Large thumbnail,[reference](#thumbnail) | √ | √  | √ | √ |


<span id="fileType">**fileType**</span>: Media type definition

```objc
kFileTypeImage      = 1 << 0
kFileTypeGif        = 1 << 1
kFileTypeVideo      = 1 << 2
kFileTypeAudio      = 1 << 3
kFileTypeFile       = 1 << 4
```

<span id="helpInfo">HelpInfo</span>: The server is only responsible for saving, meaningless to the server

```json
{
    "helpInt": 12,
    "helpText": "xxxx",
    "lastModifyTime": 1480665083.080785
}
```

<span id="userInfo">**UserInfo**</span>: User Info

```json
{
    "id": 12,
    "name": "displayName",
    "createTime": 123123123.00,
    "lastLoginDate": 1480665083.080785,
    "helpInt": 20,
    "helpText": "only for client"
}
```

<span id="catalogInfo">**CatalogInfo**</span>: Catalog Info

```json
{
    "id": 123,
    "rootId": 1,
    "parentId": 1,
    "name": "display name",
    "createTime": 123123.123,
    "lastModifyTime": 12312312.123,
    "memo": "xxx",
    "subCatalogCount": 0,
    "fileCount": 100,
    "helpInt": 123,
    "helpText": "only for client"
}
```

<span id="fileInfo">**FileInfo**</span>: File info

```json
{
    "id": 123,
    "uploadUserId": 1,
    "catalogId": 1,
    "name": "display name",
    "ext": "mp4",
    "createTime": 123123,
    "uploadTime": 3243423,
    "importTime": 98123,
    "lastModifyTime": 1231.12,
    "size": 123123,
    "type": 0,
    "duration": 1231.12,
    "width": 300,
    "height": 400,
    "orientation": 0,
    "memo": "jjjj",
    "helpInt": 12,
    "helpText": "XXXX",
    "uploadingThumbSize": 0,
    "uploadingScreenSize": 0,
    "uploadingOriginSize": 0
}
```

PS:
* **uploadingThumbSize**: Indicates the size of the thumbnail that has been uploaded
* **uploadingScreenSize**: Large thumbnail
* **uploadingOriginSize**: Original file
The above three parameters will only be returned if the file has not been uploaded successfully.
After the client has uploaded the file information, before uploading the contents of the file, you can get the number of bytes have been uploaded,
And then upload the follow-up content. Reference Api: [uploadFileInfo](#uploadFileInfo), [uploadFile](#uploadFile)

<span id="pageInfo">**PageInfo**</span>: Paging information

```json
{
    "pageIndex": 0,
    "maxPerPage": 10,
    "pageCount": 100
}
```

## Account related interface

### login.icc
login to server

| Request method | POST |
| -------- | --- |
|||
| Request parameter | Type | Description |
| userName | string | Login name, case sensitive |
| password | string | Login password |
|||
| Reponse Data | **[UserInfo](#userInfo)** |


### logout.icc 
logout server

| Request method | POST |
| -------- | --- |
|||
| Request parameter | Type | Description |
| not need param | ||
|||
|  Reponse Dat | nothing |


## HelpInfo related interface

### helpInfo.icc 
Gets the auxiliary information for the specified record

| Request method | GET |
| -------- | --- |
|||
| Request parameter | Type | Description |
| type | int | Specify the table, 0->User Table; 1->Catalog Table; 2->File Table |
| id | int | Related type id, user table does not need this value |
|||
| Reponse Data | **[HelpInfo](#helpInfo)** |


### updateHelpInfo.icc 
Set the auxiliary information for the specified record

| Request method | POST |
| -------- | --- |
|||
| Request parameter | Type | Description |
| type | int | same as **helpInfo.icc** |
| id | int |same as **helpInfo.icc** |
| helpInt | int | optional |
| helpText | string | optional |
|||
| Reponse Data | nothing |


## Catalog related interface

### catalogs.icc 
Gets the information in the specified directory

| Request method | GET |
| -------- | --- |
|||
| Request parameter | Type | Description |
| pids | string | Request sub catalogs with specify catalog. Separated with ",". -1 is mean to get all root directory |
|||
| Reponse Data | array of **[CatalogInfo](#catalogInfo)** |


### createCatalog.icc 
create catalog

| Request method | POST |
| -------- | --- |
|||
| Request parameter | Type | Description |
| parentId | int | parent Id |
| name | string | display name, limit( 1 <= len < 100) |
| createTime | [datetime](#datetime) | Optional |
| lastModifyTime | [datetime](datetime) | Optional |
| memo | string | Optional |
| helpInt | int | Optional |
| helpText | string | Optional |
|||
| Reponse Data | **[CatalogInfo](#catalogInfo)** |


### deleteCatalog.icc 

| Request method | POST |
| -------- | --- |
|||
| Request parameter | Type | Description |
| ids | string | |
|||
| Reponse Data | "info" |


### updateCatalog.icc 

| Request method | POST |
| -------- | --- |
|||
| Request parameter | Type | Description |
| id | int | catalog id |
| parentId | int | optional. Move to the specified directory, this operation only modify the database, do not modify the actual file location |
| name | string | optional, limit( 1 <= len < 100) |
| memo | string | optional |
| helpInt | int | optional |
| helpText | string | optional |
|||
| Reponse Data | **[CatalogInfo](#catalogInfo)** |


## File related interface

### files.icc
get file list

Will return file list with [fileStatus](#fileStatus) is kFileStatusFromLocal or kFileStatusFromUploaded

| Request method | GET |
| -------- | --- |
|||
| Request parameter | Type | Description |
| pageIndex | int | page index, limit: >= 0 |
| maxPerPage | int | optional. Default:100, limit: 10 <= maxPerPage <= 10000 |
| rootIds | string | optional,Root id, like"1,2". Default: all |
| pids | string | optional,parent id, like"1,2,3", Default: all |
| types | string | optional, Reference [fileType](#fileType), like: "1,8,16". Default: all |
| onlySelfUpload | int | optional. Only get self upload files, Default: 0 |
| sort | int | optional. Ord type, **>0**: asc, **<0**:desc,**0**:not sort. Default: 0. Reference:[sort](#sort) |
|||
| Reponse Data | [fileResponse](#fileResponse) |

<span id="sort">**sort**</span>

| sort value | meaning |
| ---- | ---- |
| 0 | not sort |
| 1, -1 | file create time |
| 2, -2 | upload time |
| 3, -3 | file size |
| 4, -4 | duration time |
| 5, -5 | file display size( width, height ) |


<span id="fileResponse">**fileResponse**</span>

>{
    "list": [{[fileInfo](#fileInfo)}],
    "page": {[pageInfo](#pageInfo)}
}

<span id="thumbnail"/>

### thumbnail.icc
get file thumbnail

This interface will determine the relevant [fileStatus](#fileStatus) to confirm whether to automatically generate thumbnails.
In the [upload interface](#uploadFileInfo) need to set **statusForThumb**, **statusForScreen**

| Request method | GET |
| -------- | --- |
|||
| Request parameter | Type | Description |
| id | int | file Id, only effect when [fileType](#fileType) is Image, Gif or Video |
| level | int | [thumb level](#thumbnailInfo). Default: 0 |
|||
| Reponse Data | image data or JSON data(error info) |

<span id="thumbnailInfo">thumbnail information</span>

| level value | meaning | build by server |
| ---- | ---- | ------ |
| 0 | A maximum of 100 * 100 isometric thumbnails | by [statusForThumb](#fileStatus) |
| 1 | 800 * 800 | by [statusForScreen](#fileStatus) |

<span id="fileStatus">fileStatus Description</span>

| fileStatus value | meaning |
| ---- | ---- | ------ |
| 0 | The default value, used when using [scanDisk](#scanDisk), indicates that it is automatically generated when needed |
| 1 | The server can not generate the specified thumbnail |
| 2 | Wait for the client to upload |
| 3 | The client is finished uploading |


### downFile.icc_ext
Support breakpoint download. only single Range
**_ext**: Indicates the extension, which is modified for iOS online play. It does not participate in the calculation, just a form of URL

The following two ways are possible:

downFile.icc?id=12

downFile.icc.mp4?id=12

| Request method | GET |
| -------- | --- |
| Request parameter | Type | Description |
| id | int | |
|||
| Reponse Data | file content |



### shareFileUrl.icc
Gets the shared HTTP address for the specified resource

| Request method | GET |
| -------- | --- |
|||
| Request parameter | Type | Description |
| id | int | file id |
|||
| Reponse Data | Resource address (valid time configured by appConfig.json)|

```json
{
    "shareKey"
}
```


### shareFile.icc_ext
Support breakpoint download. only single Range
Get the share file content
This interface does not need **login**

**_ext**: like **downFile.icc**

The following two ways are possible:

shareFile.icc.mp4?shareKey=xxxx

shareFile.icc.mov?shareKey=xxx

| Request method | GET |
| -------- | --- |
|||
| Request parameter | Type | Description |
| shareKey | string | result by **shareFileUrl.icc** |
|||
| Reponse Data | content |


<span id="uploadFileInfo"/>

### uploadFileInfo.icc

Upload the file, the first upload their information, and then upload the contents of the file
 
| Request method | POST |
| -------- | --- |
|||
| Request parameter | Type | Description |
| cid | int | file catalog ID |
| name | string | file display name |
| size | int | file size |
| type | [fileType](#fileType) | type |
| ext | string | file ext, len limit: (0, 10) |
| [statusForThumb](#fileStatus) | int | opt. Thumbnail image generation mode. <br>Default is kFileStatusFromLocal |
| [statusForScreen](#fileStatus) | int | opt. like **statusForThumb** |
| createTime | [datetime](#datetime) | opt |
| importTime | [datetime](#datetime) | opt |
| lastModifyTime | [datetime](#datetime) | opt |
| duration | float | opt |
| width | int | opt |
| height | int | opt |
| [orientation](#orientation) | int | opt |
| longitude | double | opt |
| latitude | double | opt |
| memo | string |  opt. limit 1024 |
| helpInt | int | opt |
| helpText | string | opt |
|||
| 响应Data | [FileInfo](#fileInfo) |


### uploadingInfo.icc
Get the information of currently uploading

| Request method | GET |
| -------- | --- |
|||
| Request parameter | Type | Description |
| nothin | | |
|||
| Reponse Data | array of [fileInfo](#fileInfo) |


<span id="uploadFile">

### uploadFile.icc

upload file content

| Request method | POST |
| -------- | ----- |
|The following parameters are generated with the URL. like: uploadFile.icc?id=1&obp=82331&tbp=0&sbp=100&cm=sha1 |
|--- |
| Request parameter | Type | Description |
| ---- | ---- | ---- |
| id | int | file id |
| obp | int | opt. Default:0;origin begin position, correspond **multidata**'s filename: **origin** |
| tbp | int | opt. Default:0;small thumbnail begin position. correspond: **thumb** |
| sbp | int | opt ,Default: 0;large thumbnail begin position. correspond: **screen** |
| cm | string | opt, Default: None, Returns the checked value of the uploaded file. Support:sha1, md5 |
| **multipart/form-data**'s file name and info |
| origin | bin | origin file |
| thumb | bin | small thumbnail image |
| screen | bin | large thumbnail image |
|||
| Reponse Data | [Response](#uploadResponse) |

<span id="uploadResponse">**uploadResponse**</span>

>{
    "fileInfo": {[fileInfo](#fileInfo)},
    "check": {"origin": "sha1 or md5 or none value", "thumb": "xxx", "screen": "xxx"}
}


### deleteFiles.icc


| Request method | POST |
| -------- | --- |
|||
| Request parameter | Type | Description |
| ids | string | wait delete file ids. separate with "," |
|||
| Reponse Data | nothing |


### updateFile.icc


| Request method | POST |
| -------- | --- |
|||
| Request parameter | Type | Description |
| id | int | file id |
| catalogId | int | opt. new catalog id. only change db info. |
| name | string | opt, fiile display name |
| size | int | opt. file size |
| type | [fileType](#fileType) | opt |
| ext | string | opt |
| [statusForThumb](#fileStatus) | int | opt |
| [statusForScreen](#fileStatus) | int | opt |
| createTime | [datetime](#datetime) | opt |
| importTime | [datetime](#datetime) | opt |
| lastModifyTime | [datetime](#datetime) | opt |
| duration | float | opt. only effect when file is gif or video |
| longitude | double | opt |
| latitude | double | opt |
| width | int | opt |
| height | int |  opt |
| [orientation](#orientation) | int | opt |
| memo | string |  opt. len limit: 1024 |
| helpInt | int | opt |
| helpText | string | opt |
|||
| Reponse Data | [FileInfo](#fileInfo) |
