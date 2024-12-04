Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4BDB63858D20; Wed,  4 Dec 2024 15:54:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4BDB63858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733327641;
	bh=Q2qPqktXh5cRP0q7rNeWBhPiDGNufYJJgMlP6E0rA34=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mCA+T48FsAo37yjAymN70Pc6wpkSiizLij1OohMTPEYcPUniRm1pU+s2h36WNIdFb
	 j+2n3vnu6N5lkzO7cYhASDOLvj3TizSN9KKVGgwRwuO/OsM9DMYjfCHq+0j1w2CSIR
	 YOBOL0iR8hsyVaQK5BKxKWFtiUshkgXbodyaxRQY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 08252A80659; Wed,  4 Dec 2024 16:53:50 +0100 (CET)
Date: Wed, 4 Dec 2024 16:53:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [EXTERNAL] Re: [PATCH] Fix compatibility with GCC 15
Message-ID: <Z1B7Dfbw5eczrbBI@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Radek Barton <radek.barton@microsoft.com>,
	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <VI0PR83MB0738D008CBD47680FAFCA78692362@VI0PR83MB0738.EURPRD83.prod.outlook.com>
 <Z08U6riwO_OA0hmk@calimero.vinschen.de>
 <VI0PR83MB07386AD9A5877C7D003527A292372@VI0PR83MB0738.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI0PR83MB07386AD9A5877C7D003527A292372@VI0PR83MB0738.EURPRD83.prod.outlook.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Radek,

On Dec  4 12:41, Radek Barton via Cygwin-patches wrote:
> Hello, Corinna.
> 
> Unfortunately I cannot send the patch using `git send-mail` using my work address for technical reasons. What I can do is to send a plain text message with the output of `git format-patch --signoff -1 HEAD` pasted.

I pushed your patch, thank you.  In future, you can simply attach the
patch to the mail rather than appending inline.  This also avoids
problems with some mailers breaking whitespaces.


Thanks again,
Corinna
