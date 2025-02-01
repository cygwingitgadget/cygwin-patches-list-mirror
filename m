Return-Path: <SRS0=Ktoe=UY=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id 4B7663858D39
	for <cygwin-patches@cygwin.com>; Sat,  1 Feb 2025 18:48:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4B7663858D39
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4B7663858D39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1738435680; cv=none;
	b=xsCoKPTyme9zVz0Gbwcwe0NsK/eyZpVwYceRsCF+Epw08vauaYnkRIkfVMTnsFlnXmTnyVnQKeRA81tMkFAULVhgpvUBmbLgqrQ0u3MILh9oBn3mTelyWAZf0R496ESzGPqTrsNJdUP6N/uJ5cpa5Ye0jtLL93ABbNlh+xOA5M0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1738435680; c=relaxed/simple;
	bh=TsSW9uQAkApIYC6tWxaAJd9ZLt49vwHack4e4sCmes4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=F6tCumuAzZK/Y1PqOAIg+FDh8IfBmd+oraqXi4D7r12GL8c+jmsBvoO9fqOvofKkqwb8WAWjmTvJseqX67zymu9beByt/0jQMH1qaHoaLebXic0hTZ35oEoQOgLELRFbMzZKE5cjDNBE6zAoqF0R6UNyHwSuTiAYFCa6CGlNfiA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4B7663858D39
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=JIvjrI4V
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 0AE404A2D9
	for <cygwin-patches@cygwin.com>; Sat,  1 Feb 2025 18:47:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf15.hostedemail.com (Postfix) with ESMTPA id 9DF9818
	for <cygwin-patches@cygwin.com>; Sat,  1 Feb 2025 18:47:57 +0000 (UTC)
Message-ID: <b2027548-0eb7-41bf-a29e-de970043d4a0@SystematicSW.ab.ca>
Date: Sat, 1 Feb 2025 11:47:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] update Cygwin-X news page X.Org and Cygwin release
 announcements to current stable releases
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <4c395f96efe5f7e7026c91125c832d431dcc145f.1738294648.git.Brian.Inglis@SystematicSW.ab.ca>
 <17478133-a196-41bd-92f4-ac3eb7866f5c@dronecode.org.uk>
Organization: Systematic Software
In-Reply-To: <17478133-a196-41bd-92f4-ac3eb7866f5c@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DF9818
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout04
X-Stat-Signature: j1jt6io6wgjkcog85sf4ityajnass6an
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19JuQU3mw9hK95DPaC/eHZz/wzJumUqoG0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=pPOde4S4um3TozFim4G6bcADJXjD41DK9GOi0aDNUss=; b=JIvjrI4V9BLSiCUP6jZ5sKN60grKKcBBOA2LsbZS4hf4tSJMZHdDIKKgygYe2R1ANHmP9nQoX1P9GIrytlnT5z9lBnmTVHc/+Z63FmcsVy+tRgA/uTvPyGoTrcZGSC8TKy3bk7oYY14wMEOBv6kprbQbt3vR5oEnbXcpZJqM4IuypsQeVkA1oAB61PuB+lxrQrQ4A/jwFWgPhVFFWk35bFDblAm+UAfDHnwlYy9eTw66vF+MLQjwxTTYyJeC97F2OUcEWxTsIy5zT1eZsmXSXs6pZMjaTBHIM+nDe3JgnvCsPVvqfZrSKDLru0epYxrHiDsivmhx+UwwwczdzNL3jQ==
X-HE-Tag: 1738435677-90676
X-HE-Meta: U2FsdGVkX1/SXda2+7N3hpmfX6JyrhFUTKf0MYHdEc+E5R5bUfhoEsw0686A+diy9aG/Lat1BZM2RISNj0oVPvy7PA+Q/GeYtPAzZJ7SrtQRsrnJudmlrLYKCMcjSFwhyI8ZLzjmfMeUUy4IJ69nhAizIw3WYxRToLR+o3lc4pcUKdaOJLCn9yl8cvzmJoFIlA7ieKsasJ4vFoWarHXGQA9qmHN90N63hkajty5bJVZAQP60iYgWi+OnfgkPilzt2KObBMdk7HsboqOk9bfGWiijQR3UOGyUoV/jN4c5eWyidDXuad2PthYVDU9HQKHiNIlLAVuFC1OiI9zpzE7tJx3WKGUEaEb5q64osWZdnaxaTpnWvWfJQo8Y0jb1jJb73tArtLb9KMj0TIeScoCX9Oand+4QKMaw7jBNbgm99RBrGRuM4A++r3yOzFBxMYr2vf08xPsP6V1PLVisH59L6dnJgcIaRPmlo3Ocl5jwgylbmVJBoUnuswqSg3BPViR/xLvz1tHn8zRQ0u5M8o4qaS9DlcvauZBNHDk80E3eks0xO8fUooXNeTZVdEYYvTbdJ9A97JZLFhhpxJk9vgP+JenR+6CFJPpvOM7iYo7b131a8HOVwbLeqbXMWmswThcicQ02d3A42yLDw1TLfJMvuJZiLqetPwUkT98YWqf/AX4IBgQzvYEUrQcZUMnQ3w2Zrl33/sPQ/5qJ/9Ko6I7/YDvl6/ESq2EPm3GEdI4ezpNVlCI6OLIYlQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-02-01 08:52, Jon Turney wrote:
> On 31/01/2025 03:39, Brian Inglis wrote:
>> might want to change the older messages to a more general Cygwin-X FAQ reference
> 
> I don't really understand how this statement applies to the change suggested?

It is intended for the reviewer as all the entries appear old and not very 
useful, but I have no idea what else might be better to replace the later ones!

>> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> ---
>>   xfree/cygx-news-new.html | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/xfree/cygx-news-new.html b/xfree/cygx-news-new.html
>> index e326fa084c2c..a9ff136ea684 100644
>> --- a/xfree/cygx-news-new.html
>> +++ b/xfree/cygx-news-new.html
>> @@ -1,14 +1,14 @@
>>   <p>
>> -<a href="https://lists.x.org/archives/xorg-announce/2021-October/003115.html">
>> -X server 21.1</a> and
> 
> Thanks, but:
> 
> This is deliberately the major release number.
> 
>> -<a href="http://lists.x.org/archives/xorg-announce/2012-June/001977.html">
>> -X.Org X11 Release 7.7</a>
>> +<a href="https://lists.x.org/archives/xorg-announce/2024-December/003576.html">
>> +X.Org X Server 21.1.15</a> and
>> +<a href="https://lists.x.org/archives/xorg-announce/2024-July/003521.html">
>> +X.Org X11 Release 1.8.10</a>
> 
> This is wrong.
> 
> R7.7 is the X11 rollup release number (informally called a "katamari"), 
> inherited from the days when X11 was distributed as a monolithic source tree.

Not very useful any more for any one for any reason - even then it was only 
really a binary flag for current or outdated X releases, especially for 
commercial Unixen.

> This is not the libX11 version number.
> 
>>   are included in Cygwin.
>> -Details are available in the announcements
>> -<a href="https://cygwin.com/pipermail/cygwin-announce/2021- 
>> November/010286.html">
>> -here</a> and
>> -<a href="http://cygwin.com/ml/cygwin-xfree-announce/2012-07/msg00001.html">
>> -here</a>.
>> +Details are available in the announcements of the respective Cygwin packages
>> +<a href="https://cygwin.com/pipermail/cygwin-announce/2025-January/012120.html">
>> +X.Org Server 21.1.15</a> and
>> +<a href="https://cygwin.com/pipermail/cygwin-announce/2025-January/012082.html">
>> +X.Org X11 refresh</a>.
>>   </p>
> 
> If I was going to change this, I'd probably just remove it all, since X11 
> development velocity is slow enough these days that it doesn't really 
> communicate much useful information.

As suggested at the top, maybe just a link to the Cygwin-X FAQ?

I just notice ancient dates and think that is no longer current, informative, or 
useful - it needs changed to something more current, informative, and useful.
That keeps me posting patches, and ITAs if I need or use a package! ;^>

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
