Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5C15A3858CDA; Fri, 28 Jul 2023 19:28:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5C15A3858CDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1690572486;
	bh=6zWJgonN4v4EsAF7Z2TLfecjNiAf6JQE7nAXgpChPc4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fnv2ljBzxCJ1VsvL3cWJ5wcZKnRv+cURndpf8vSVXf6iWvT3zNZwnsykW66chEyeO
	 YYqrgRpjZBs7gi4IeU8gM7XAyjZ4ls8Ynnl7ISwsg/OJDtQ3HJOBe8mx3qwrywSaJZ
	 WwPTCL3j6qzeSIzKWfVQJky6+PAbLah+YUb0n85U=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6F093A80C7B; Fri, 28 Jul 2023 21:28:04 +0200 (CEST)
Date: Fri, 28 Jul 2023 21:28:04 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Pedro Alves <pedro@palves.net>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/5] Cygwin: add AT_EMPTY_PATH fix to release message
Message-ID: <ZMQWxAW5J5wdSBev@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Pedro Alves <pedro@palves.net>, cygwin-patches@cygwin.com
References: <20230712120804.2992142-1-corinna-cygwin@cygwin.com>
 <20230712120804.2992142-6-corinna-cygwin@cygwin.com>
 <135bb49e-08b3-865e-a19f-6aab03a5f348@palves.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <135bb49e-08b3-865e-a19f-6aab03a5f348@palves.net>
List-Id: <cygwin-patches.cygwin.com>

On Jul 28 17:11, Pedro Alves wrote:
> On 2023-07-12 13:08, Corinna Vinschen wrote:
> > +- Fix AT_EMPTY_PATH handling in fchmodat and fstatat if dirfd referres to
> 
> referres -> refers

Oops, sorry, too late :}
