Return-Path: <cygwin-patches-return-7104-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14687 invoked by alias); 13 Sep 2010 11:28:20 -0000
Received: (qmail 14670 invoked by uid 22791); 13 Sep 2010 11:28:19 -0000
X-SWARE-Spam-Status: No, hits=0.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f43.google.com (HELO mail-fx0-f43.google.com) (209.85.161.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 13 Sep 2010 11:28:14 +0000
Received: by fxm9 with SMTP id 9so4376320fxm.2        for <cygwin-patches@cygwin.com>; Mon, 13 Sep 2010 04:28:11 -0700 (PDT)
Received: by 10.223.105.82 with SMTP id s18mr1895375fao.77.1284377291657;        Mon, 13 Sep 2010 04:28:11 -0700 (PDT)
Received: from [10.71.1.25] (wall-ext.hola.org [212.235.66.73])        by mx.google.com with ESMTPS id r10sm2744230faq.5.2010.09.13.04.28.10        (version=SSLv3 cipher=RC4-MD5);        Mon, 13 Sep 2010 04:28:10 -0700 (PDT)
Message-ID: <4C8E0AC7.9080409@gmail.com>
Date: Mon, 13 Sep 2010 11:28:00 -0000
From: Yoni Londner <yonihola2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.12) Gecko/20100824 Thunderbird/3.0.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de> <20100910150840.GD16534@calimero.vinschen.de> <20100910172312.GA23015@ednor.casa.cgf.cx> <20100910183940.GA14132@calimero.vinschen.de> <4C8C9408.3060304@gmail.com> <20100912114115.GA1113@calimero.vinschen.de>
In-Reply-To: <20100912114115.GA1113@calimero.vinschen.de>
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
X-SW-Source: 2010-q3/txt/msg00064.txt.bz2

Hi,

 > However, isn't that kind of a chicken/egg situation?  If you want to
 > reuse the content of the FILE_BOTH{_ID}_DIRECTORY_INFORMATION structure
 > from a previous call to readdir, you would have to call the

I am not talking about reusing info from a previous readdir.

Every single file cygwin tries to access, it does it in a loop, trying 
afterwards to check for *.lnk file.

Using the directory query operations, it is possible to get this info 
faster:
instead of getting file info for FOO and then for "FOO.lnk",
Cygwin can query the directory info for "FOO FOO.LNK" (for the file 
requested, plus its possible symlink file).

Yoni

On 12/9/2010 1:41 PM, Corinna Vinschen wrote:
> On Sep 12 10:49, Yoni Londner wrote:
>> Hi,
>>
>> The caching-speed up is trivial:
>> We store the the FileFullDirectoryInformation fields, and if any of
>> them change - we re-read the file.
>>
>> Its not (in practical life) possible to change a file without
>> causing a modification on FileIndex/CreationTime/LastWriteTime/ChangeTime/EndOfFile/AllocationSize/FileAttributes/FileName/EaSize!
>>
>>  From the MSDN we see the info we can get on a
>> FileFullDirectoryInformation request:
>
> We're already using FileBothDirectoryInformation and
> FileBothIdDirectoryInformation in readdir anyway.
>
> However, isn't that kind of a chicken/egg situation?  If you want to
> reuse the content of the FILE_BOTH{_ID}_DIRECTORY_INFORMATION structure
> from a previous call to readdir, you would have to call the
> corresponding NtQueryInformationFile call(s) to fetch the information
> from the file for comparision purposes.  When you fetched it anyway,
> there's no reason anymore to compare them, since you can use what
> you just fetched.  Where's the advantage?
>
>
> Corinna
>
