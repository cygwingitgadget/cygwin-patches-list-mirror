Return-Path: <SRS0=dVow=LO=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 05BBB3858CDA
	for <cygwin-patches@cygwin.com>; Tue,  9 Apr 2024 16:38:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 05BBB3858CDA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 05BBB3858CDA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1712680714; cv=none;
	b=rLFc9EakzNQ3p8nizS6tWJn9jD+h9G7cazRbqUfcxu55Xd7gWDGvou3wb/r6phVnEkBKSsiuOip4iVs8LqBklVGisa+0V0Fhd2DW/LarjrAR7IwcSg6wBtRRXlRuJxcarrDvOUlvBea8Tnk4Baf9qmtB+4qs8tJvH8fenXRM0ck=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1712680714; c=relaxed/simple;
	bh=5bZ0FHGO746DwKhsBgLQFnRnsOoShGxTmjQSNrpvPjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=JcVD6GxsuvMkgy8OFxp/k+nsLyyl2DHCcNsXci3KtH3R4Ev41tg8gLSw/3k7K/hJlK/rSoDW6APTP9vtl5U8FeVHXh83tp6kMdpf6Dk7Jrq4IdEJzhRHcCrjro8qjz2177l62xjFSlr7DC4mXzCtyJxDTkijc3ade+mU6yby+t0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 6464EC04BF
	for <cygwin-patches@cygwin.com>; Tue,  9 Apr 2024 16:38:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf15.hostedemail.com (Postfix) with ESMTPA id D8C391A
	for <cygwin-patches@cygwin.com>; Tue,  9 Apr 2024 16:38:30 +0000 (UTC)
Message-ID: <8180fe90-776b-4ba0-9752-09186a08d771@SystematicSW.ab.ca>
Date: Tue, 9 Apr 2024 10:38:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: /proc/<pid>/{cwd, root} links to <defunct> for cygrunsrv,
 daemons, and shells
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <0df79ac3-02ea-4180-8177-375407dee2a1@SystematicSW.ab.ca>
 <ZhU9yqAGCtJzcNGn@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <ZhU9yqAGCtJzcNGn@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 67zcz5tcrfa3rhboke5r7oiy63gq33hp
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: D8C391A
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/xcdCR8DO/mMeA9AgZz+5mMhkz/71BcI4=
X-HE-Tag: 1712680710-655411
X-HE-Meta: U2FsdGVkX1/OWSNaks2sgiylCDkE6a/2eJaNe2pLEUUgbciTiP7rWR4y0wOLwVTSKxbfT6yGpw2q3GKVD/4rgYXjtUvvuuHYajhyKoOHN4tyZWKCcyQvCQA0Xn1JavwxtgMo+UXaQWfRYIi7/mzhYiY7wLNEparekiu9UHsGW3N8MVDhC1r/B6aH9yWXocWBC7pg8R84nr2NLPC630fGplFw4fCI2dBcrckuFYDGZe6ORGi/Ib4u+3FwIRZ6d/fMw9cFoZHv52sGTnHFSvcP1bTe5Bo7Hyk0oNmGP1KjWbDHwVjGOA15p3aLwzH3n0RzuZMex2ZxRKuZqBpsCIfvx/ByXD3779+J
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2024-04-09 07:08, Corinna Vinschen wrote:
> On Apr  7 13:34, Brian Inglis wrote:
>> ISTM anomalous that for cygrunsrv, daemons, cron processes, and shells
>> /proc/<pid>/{cwd,root} have bad symlinks to "<defunct>", normally a process
>> or exe status:
>>
>> /proc/732/exe   -> /usr/bin/cygrunsrv
>> /proc/732/root  -> <defunct>
>> /proc/732/cwd   -> <defunct>
>> |  /proc/733/exe   -> /usr/sbin/cygserver
>>   ->/proc/733/root  -> <defunct>
>>     /proc/733/cwd   -> <defunct>
>> /proc/740/exe   -> /usr/bin/cygrunsrv
>> /proc/740/root  -> <defunct>
>> /proc/740/cwd   -> <defunct>
>> |  /proc/741/exe   -> /usr/sbin/syslog-ng
>>   ->/proc/741/root  -> <defunct>
>>     /proc/741/cwd   -> <defunct>
>> /proc/748/exe   -> /usr/bin/cygrunsrv
>> /proc/748/root  -> <defunct>
>> /proc/748/cwd   -> <defunct>
>> |  /proc/749/exe   -> /usr/sbin/cron
>>   ->/proc/749/root  -> <defunct>
>>     /proc/749/cwd   -> <defunct>
>>     |  /proc/2080/exe  -> /usr/sbin/cron
>>      ->/proc/2080/root -> <defunct>
>>        /proc/2080/cwd  -> <defunct>
>>        |  /proc/2082/exe  -> /usr/bin/bash
>>         ->/proc/2082/root -> <defunct>
>>           /proc/2082/cwd  -> <defunct>
>>
>> Should we consider changing that to root "/", or nothing, null, or something
>> meaningful?
> 
> That's typically a permission problem.  On Linux you get something like
> 
>    ls: cannot read symbolic link '/proc/1/cwd': Permission denied

Thanks Corinna,

That now makes sense, as Cygwin ps -a and btop showed the processes, although 
procps and top did not, and other info is visible, I never thought about 
permissions as there were links, but I see from elevated admin sh:

/proc/732/exe   -> /usr/bin/cygrunsrv
/proc/732/root  -> /
/proc/732/cwd   -> /proc/cygdrive/c/WINDOWS/system32
|  /proc/733/exe   -> /usr/sbin/cygserver
  ->/proc/733/root  -> /
    /proc/733/cwd   -> /proc/cygdrive/WINDOWS/system32
/proc/740/exe   -> /usr/bin/cygrunsrv
/proc/740/root  -> /
/proc/740/cwd   -> /proc/cygdrive/WINDOWS/system32
|  /proc/741/exe   -> /usr/sbin/syslog-ng
  ->/proc/741/root  -> /
    /proc/741/cwd   -> /proc/cygdrive/WINDOWS/system32
/proc/748/exe   -> /usr/bin/cygrunsrv
/proc/748/root  -> /
/proc/748/cwd   -> /proc/cygdrive/WINDOWS/system32
|  /proc/749/exe   -> /usr/sbin/cron
  ->/proc/749/root  -> /
    /proc/749/cwd   -> /var/cron

and from normal mintty bash:

$ stat -L -c%a\ %A\ %n /proc/732/*
444 -r--r--r-- /proc/732/cmdline
444 -r--r--r-- /proc/732/ctty
stat: cannot stat '/proc/732/cwd': No such file or directory
444 -r--r--r-- /proc/732/environ
755 -rwxr-xr-x /proc/732/exe
444 -r--r--r-- /proc/732/exename
555 dr-xr-xr-x /proc/732/fd
444 -r--r--r-- /proc/732/gid
444 -r--r--r-- /proc/732/maps
444 -r--r--r-- /proc/732/mountinfo
444 -r--r--r-- /proc/732/mounts
444 -r--r--r-- /proc/732/pgid
444 -r--r--r-- /proc/732/ppid
stat: cannot stat '/proc/732/root': No such file or directory
444 -r--r--r-- /proc/732/sid
444 -r--r--r-- /proc/732/stat
444 -r--r--r-- /proc/732/statm
444 -r--r--r-- /proc/732/status
444 -r--r--r-- /proc/732/uid
444 -r--r--r-- /proc/732/winexename
444 -r--r--r-- /proc/732/winpid
$ more /proc/732/* > /dev/null
more: cannot open /proc/732/cwd: No such file or directory
more: cannot open /proc/732/maps: Permission denied
more: cannot open /proc/732/root: No such file or directory
more: cannot open /proc/732/stat: Permission denied
more: cannot open /proc/732/statm: Permission denied

so I think perms on these should be 440 or 550 not 444 or 555, but that may 
involve a lot of work to decide that for each entry?

> But on Cygwin the content of those links require to open the processes'
> signal pipe and send/receive a message containing the information.  I
> didn't look into the code for a while but it seems we don't check why we
> couldn't connect to a process to fetch the info. IIRC the current
> fhandler_process framework doesn't have a way to communicate that
> info.
> 
> If you want to change that, feel free!

I will take a look sometime but no promises of any patch(es) ;^>

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

