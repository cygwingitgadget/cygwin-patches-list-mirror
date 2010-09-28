Return-Path: <cygwin-patches-return-7116-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4712 invoked by alias); 28 Sep 2010 04:59:05 -0000
Received: (qmail 4700 invoked by uid 22791); 28 Sep 2010 04:59:04 -0000
X-SWARE-Spam-Status: No, hits=0.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,TW_CG,TW_GF,TW_HG,TW_VM,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f43.google.com (HELO mail-fx0-f43.google.com) (209.85.161.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 28 Sep 2010 04:58:58 +0000
Received: by fxm7 with SMTP id 7so5423053fxm.2        for <cygwin-patches@cygwin.com>; Mon, 27 Sep 2010 21:58:56 -0700 (PDT)
Received: by 10.223.118.71 with SMTP id u7mr4391480faq.103.1285649936453;        Mon, 27 Sep 2010 21:58:56 -0700 (PDT)
Received: from [10.71.1.25] (wall-ext.hola.org [212.235.66.73])        by mx.google.com with ESMTPS id r8sm2870622faq.10.2010.09.27.21.58.54        (version=SSLv3 cipher=RC4-MD5);        Mon, 27 Sep 2010 21:58:55 -0700 (PDT)
Message-ID: <4CA1760B.4000407@gmail.com>
Date: Tue, 28 Sep 2010 04:59:00 -0000
From: Yoni Londner <yonihola2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <4C8E0EED.4000606@gmail.com> <20100914093859.GB15121@calimero.vinschen.de> <4C999916.7080609@gmail.com> <20100922134412.GA4817@ednor.casa.cgf.cx>
In-Reply-To: <20100922134412.GA4817@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2010-q3/txt/msg00076.txt.bz2

Hi,

 > What is /mnt/hgfs/C in this case? How is it mounted?

.host:/ on /mnt/hgfs type vmhgfs (rw,ttl=5)

I am now preparing an easy to use scandir/stat performance testing 
program that will perform it in various methods and printout comparison 
results in an easy to use manner.
It will compare cygwin API (to allow us to see how cygwin1.dll changes 
affect performance), and various native Windows APIs - so we can see how 
much room there is for improvement.

I hope to be able to post this program tomorrow.

Yoni

~$ cat /etc/fstab
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
proc            /proc           proc    defaults        0       0
/dev/sda1       /               ext3    errors=remount-ro 0       1
/dev/sda5       none            swap    sw              0       0
/dev/hda        /media/cdrom0   udf,iso9660 user,noauto     0       0
/dev/fd0        /media/floppy0  auto    rw,user,noauto  0       0
# Beginning of the block added by the VMware software
.host:/                 /mnt/hgfs               vmhgfs  defaults,ttl=5 
    0 0
# End of the block added by the VMware software


On 22/9/2010 3:44 PM, Christopher Faylor wrote:
> On Wed, Sep 22, 2010 at 07:50:14AM +0200, Yoni Londner wrote:
>> Hi,
>>
>>> I'm not exactly concerned about Linux being way faster accessing an NTFS
>>> drive.  After all it's the OS itself and comes with it's own NTFS driver
>>> which obviously is streamlined for typical POSIX operations.
>>
>> I did not test&  compare to using the Linux NTFS, rather I compared with
>> Linux on VMWARE using the same Windows NTFS.SYS (via the same
>> kernel32.dll APIs):
>>
>> Cygwin: "C:/cygwin/bin/ls.exe /bin" ->  cygwin1.dll ->  kernel32.dll ->
>> NTOS kernel ->  NTFS.SYS driver ->  HD
>>
>> linux: "/bin/ls /mnt/hgfs/C/cygwin/bin" ->  glibc ->  linux kernel ->
>> VMWARE hgfs driver ->  vmware_player.exe (on Win32) ->   kernel32.dll ->
>> NTOS kernel ->  NTFS.SYS driver ->  HD
>>
>> As you can see the VMWARE path is much longer than Cygwin, and it passes
>> the same APIs and NTFS.SYS driver, and yet it executes much faster.
>>
>> This helps us understand that there is a lot that still can be done in
>> Cygwin's filesystem performance.
>
> What is /mnt/hgfs/C in this case?  How is it mounted?
>
> cgf
