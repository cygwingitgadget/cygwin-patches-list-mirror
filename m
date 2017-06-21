Return-Path: <cygwin-patches-return-8792-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 117106 invoked by alias); 21 Jun 2017 17:54:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 117088 invoked by uid 89); 21 Jun 2017 17:54:12 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.2 spammy=watching, ume, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail.pismotechnic.com
Received: from mail.pismotechnic.com (HELO mail.pismotechnic.com) (162.218.67.164) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Jun 2017 17:54:11 +0000
Received: from [10.2.1.30] (unknown [73.240.197.175])	by mail.pismotechnic.com (Postfix) with ESMTPSA id 36BDD160DFC	for <cygwin-patches@cygwin.com>; Wed, 21 Jun 2017 10:54:09 -0700 (PDT)
Message-ID: <594AB2BB.3060307@pismotec.com>
Date: Wed, 21 Jun 2017 17:54:00 -0000
From: Joe Lowe <joe@pismotec.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:25.9) Gecko/20160412 FossaMail/25.2.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Compatibility improvement to reparse point handling, v3
References: <594199C4.9080804@pismotec.com> <20170619114532.GC26654@calimero.vinschen.de> <59481C4D.5030206@pismotec.com> <20170620081728.GB8342@calimero.vinschen.de>
In-Reply-To: <20170620081728.GB8342@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00063.txt.bz2



On 2017-06-20 01:17, Corinna Vinschen wrote:
> Actually, DT_UNKNOWN indicates nothing.  The sole purpose of this
> value is to tell the application that the information is not readily
> available without having to perform costly operations, which often

OK.

> I pushed your patch, plus a follow-up patch to handle remote reparse
> points correctly, as outlined in my previous reply.

Thanks, and for catching the isremote() fix.

I adhoc tested against a variety of symlink and mountpoint reparse
points. I dont see any issues, and changes are working as expected.
I will keep watching the dev and patch mail lists for a while, but if
some issues pop-up then feel free to contact me directly.

Joe L.


Some test results.
Previous cygwin.

joe@dev /cygdrive/c/Volumes
$ ls -ladsh *
0 lrwxrwxrwx  1 joe None 51 Jun 21 09:58 file_device_symlink.txt -> /cygdrive/c/Device/HarddiskVolume13/folder/file.txt
0 lrwxrwxrwx  1 joe None 27 Jun 21 09:58 file_drive_symlink.txt -> /cygdrive/g/folder/file.txt
0 lrwxrwxrwx  1 joe None 69 Jun 21 09:58 file_guid_symlink.txt -> /cygdrive/c/ume{0fe73790-e32c-11e6-827a-bc5ff473f2ab}/folder/file.txt
0 lrwxrwxrwx  1 joe None 15 Jun 21 09:58 file_relative_symlink.txt -> folder/file.txt
0 drwxrwx---+ 1 joe None  0 Jun 21 09:55 folder
0 lrwxrwxrwx  1 joe None 42 Jun 21 09:58 folder_device_mountpoint -> /cygdrive/c/Device/HarddiskVolume13/folder
0 lrwxrwxrwx  1 joe None 42 Jun 21 09:58 folder_device_symlink -> /cygdrive/c/Device/HarddiskVolume13/folder
0 lrwxrwxrwx  1 joe None 18 Jun 21 09:58 folder_drive_mountpoint -> /cygdrive/g/folder
0 lrwxrwxrwx  1 joe None 18 Jun 21 09:58 folder_drive_symlink -> /cygdrive/g/folder
0 drwxr-xr-x  1 joe None  0 Jun 21 09:55 folder_guid_mountpoint
0 lrwxrwxrwx  1 joe None 60 Jun 21 09:58 folder_guid_symlink -> /cygdrive/c/ume{0fe73790-e32c-11e6-827a-bc5ff473f2ab}/folder
0 lrwxrwxrwx  1 joe None  6 Jun 21 09:58 folder_relative_symlink -> folder
0 lrwxrwxrwx  1 joe None 36 Jun 21 09:58 volume_device_mountpoint -> /cygdrive/c/Device/HarddiskVolume13/
0 lrwxrwxrwx  1 joe None 36 Jun 21 09:58 volume_device_symlink -> /cygdrive/c/Device/HarddiskVolume13/
0 lrwxrwxrwx  1 joe None 11 Jun 21 09:58 volume_drive_mountpoint -> /cygdrive/g
0 lrwxrwxrwx  1 joe None 11 Jun 21 09:58 volume_drive_symlink -> /cygdrive/g
0 drwxr-xr-x  1 joe None  0 Dec 31  1979 volume_guid_mountpoint
0 lrwxrwxrwx  1 joe None 54 Jun 21 09:58 volume_guid_symlink -> /cygdrive/c/ume{0fe73790-e32c-11e6-827a-bc5ff473f2ab}/

joe@dev /cygdrive/c/Volumes
$ grep -r hello .
./folder/file.txt:hello
./folder_guid_mountpoint/file.txt:hello
./volume_guid_mountpoint/folder/file.txt:hello


Updated cygwin.

joe@dev /cygdrive/c/Volumes
$ ls -ladsh *
4.0K -rw-r--r--  1 joe None  7 Jun 21 09:58 file_device_symlink.txt
   0 lrwxrwxrwx  1 joe None 27 Jun 21 09:58 file_drive_symlink.txt -> /cygdrive/g/folder/file.txt
4.0K -rw-r--r--  1 joe None  7 Jun 21 09:58 file_guid_symlink.txt
   0 lrwxrwxrwx  1 joe None 15 Jun 21 09:58 file_relative_symlink.txt -> folder/file.txt
   0 drwxrwx---+ 1 joe None  0 Jun 21 09:55 folder
   0 drwxr-xr-x  1 joe None  0 Jun 21 09:55 folder_device_mountpoint
   0 drwxr-xr-x  1 joe None  0 Jun 21 09:55 folder_device_symlink
   0 lrwxrwxrwx  1 joe None 18 Jun 21 09:58 folder_drive_mountpoint -> /cygdrive/g/folder
   0 lrwxrwxrwx  1 joe None 18 Jun 21 09:58 folder_drive_symlink -> /cygdrive/g/folder
   0 drwxr-xr-x  1 joe None  0 Jun 21 09:55 folder_guid_mountpoint
   0 drwxr-xr-x  1 joe None  0 Jun 21 09:55 folder_guid_symlink
   0 lrwxrwxrwx  1 joe None  6 Jun 21 09:58 folder_relative_symlink -> folder
   0 drwxr-xr-x  1 joe None  0 Dec 31  1979 volume_device_mountpoint
   0 drwxr-xr-x  1 joe None  0 Dec 31  1979 volume_device_symlink
   0 lrwxrwxrwx  1 joe None 11 Jun 21 09:58 volume_drive_mountpoint -> /cygdrive/g
   0 lrwxrwxrwx  1 joe None 11 Jun 21 09:58 volume_drive_symlink -> /cygdrive/g
   0 drwxr-xr-x  1 joe None  0 Dec 31  1979 volume_guid_mountpoint
   0 drwxr-xr-x  1 joe None  0 Dec 31  1979 volume_guid_symlink

joe@dev /cygdrive/c/Volumes
$ grep -r hello .
./file_device_symlink.txt:hello
./file_guid_symlink.txt:hello
./folder/file.txt:hello
./folder_device_mountpoint/file.txt:hello
./folder_device_symlink/file.txt:hello
./folder_guid_mountpoint/file.txt:hello
./folder_guid_symlink/file.txt:hello
./volume_device_mountpoint/folder/file.txt:hello
./volume_device_symlink/folder/file.txt:hello
./volume_guid_mountpoint/folder/file.txt:hello
./volume_guid_symlink/folder/file.txt:hello
