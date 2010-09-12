Return-Path: <cygwin-patches-return-7101-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11078 invoked by alias); 12 Sep 2010 08:49:43 -0000
Received: (qmail 11067 invoked by uid 22791); 12 Sep 2010 08:49:42 -0000
X-SWARE-Spam-Status: No, hits=1.0 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f43.google.com (HELO mail-fx0-f43.google.com) (209.85.161.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 12 Sep 2010 08:49:37 +0000
Received: by fxm9 with SMTP id 9so3776477fxm.2        for <cygwin-patches@cygwin.com>; Sun, 12 Sep 2010 01:49:34 -0700 (PDT)
Received: by 10.223.119.67 with SMTP id y3mr2155581faq.45.1284281374408;        Sun, 12 Sep 2010 01:49:34 -0700 (PDT)
Received: from [10.71.1.25] (wall-ext.hola.org [212.235.66.73])        by mx.google.com with ESMTPS id p2sm2235145fak.22.2010.09.12.01.49.32        (version=SSLv3 cipher=RC4-MD5);        Sun, 12 Sep 2010 01:49:33 -0700 (PDT)
Message-ID: <4C8C9408.3060304@gmail.com>
Date: Sun, 12 Sep 2010 08:49:00 -0000
From: Yoni Londner <yonihola2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.12) Gecko/20100824 Thunderbird/3.0.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <20100910150840.GD16534@calimero.vinschen.de> <20100910172312.GA23015@ednor.casa.cgf.cx> <20100910183940.GA14132@calimero.vinschen.de>
In-Reply-To: <20100910183940.GA14132@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00061.txt.bz2

Hi,

The caching-speed up is trivial:
We store the the FileFullDirectoryInformation fields, and if any of them 
change - we re-read the file.

Its not (in practical life) possible to change a file without causing a 
modification on 
FileIndex/CreationTime/LastWriteTime/ChangeTime/EndOfFile/AllocationSize/FileAttributes/FileName/EaSize!

 From the MSDN we see the info we can get on a 
FileFullDirectoryInformation request:

http://msdn.microsoft.com/en-us/library/cc232068(PROT.10).aspx

NextEntryOffset (4 bytes): A 32-bit unsigned integer that contains the 
byte offset from the beginning of this entry, at which the next 
FILE_FULL_DIR_INFORMATION entry is located, if multiple entries are 
present in a buffer. This member is zero if no other entries follow this 
one. An implementation MUST use this value to determine the location of 
the next entry (if multiple entries are present in a buffer).

FileIndex (4 bytes): A 32-bit unsigned integer that contains the byte 
offset of the file within the parent directory. For file systems such as 
NTFS, in which the position of a file within the parent directory is not 
fixed and can be changed at any time to maintain sort order, this field 
SHOULD be set to 0, and MUST be ignored.<79>

CreationTime (8 bytes): The time when the file was created; see section 
2.1.1. This value MUST be greater than or equal to 0.

LastAccessTime (8 bytes): The last time the file was accessed; see 
section 2.1.1. This value MUST be greater than or equal to 0.

LastWriteTime (8 bytes): The last time information was written to the 
file; see section 2.1.1. This value MUST be greater than or equal to 0.

ChangeTime (8 bytes): The last time the file was changed; see section 
2.1.1. This value MUST be greater than or equal to 0.

EndOfFile (8 bytes): A 64-bit signed integer that contains the absolute 
new end-of-file position as a byte offset from the start of the file. 
EndOfFile specifies the offset to the byte immediately following the 
last valid byte in the file. Because this value is zero-based, it 
actually refers to the first free byte in the file. That is, it is the 
offset from the beginning of the file at which new bytes appended to the 
file will be written. The value of this field MUST be greater than or 
equal to 0.

AllocationSize (8 bytes): A 64-bit signed integer that contains the file 
allocation size, in bytes. The value of this field MUST be an integer 
multiple of the cluster size.

FileAttributes (4 bytes): A 32-bit unsigned integer that contains the 
file attributes. For a list of valid file attributes, see section 2.6.

FileNameLength (4 bytes): A 32-bit unsigned integer that specifies the 
length, in bytes, of the file name contained within the FileName member.

EaSize (4 bytes): A 32-bit unsigned integer that contains the combined 
length, in bytes, of the extended attributes (EA) for the file.

FileName (variable): A sequence of Unicode characters containing the 
file name. When working with this field, use FileNameLength to determine 
the length of the file name rather than assuming the presence of a 
trailing null delimiter. Dot directory names are valid for this field. 
For more details, see section 2.1.5.1.

Yoni

On 10/9/2010 9:39 PM, Corinna Vinschen wrote:
> On Sep 10 13:23, Christopher Faylor wrote:
>> On Fri, Sep 10, 2010 at 05:08:40PM +0200, Corinna Vinschen wrote:
>>> What I'm still mulling over is a good idea to re-use the results of a
>>> former call to readdir in a stat call.  One problem here is to make sure
>>> that a subsequent stat call is *really* accessing the same file as the
>>> former readdir returned.
>>
>> I've considered that before but you really can't cheaply determine that
>> the file hasn't changed without going to the OS.  And, then it isn't cheap.
>
> Yes, that's what it always comes down to.  That's why I'm considering to
> restrict this speedup to fstatat.  I wrote more about this on the
> cygwin-developers list.
>
>
> Corinna
>
