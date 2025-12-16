Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A30C04BA2E20; Tue, 16 Dec 2025 12:01:10 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 95B30A804CD; Tue, 16 Dec 2025 13:01:08 +0100 (CET)
Date: Tue, 16 Dec 2025 13:01:08 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: is_console_app(): handle app execution
 aliases
Message-ID: <aUFKBBdIN5rqztD7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
 <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
 <aUAoxVEKMpj6xNjM@calimero.vinschen.de>
 <18909F97-1145-4F61-9E23-4E4B9C97CF2E@gmx.de>
 <aUAxwTZcfZ9qecW2@calimero.vinschen.de>
 <f8d06570-7208-755b-e747-e8d7d174b32d@gmx.de>
 <20251216173957.fa9571466a8bced55924884f@nifty.ne.jp>
 <4ac88404-a8c3-3d21-6460-6941fb8dff4a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ac88404-a8c3-3d21-6460-6941fb8dff4a@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

On Dec 16 10:31, Johannes Schindelin wrote:
> 2. What purpose is the name `perhaps_suffix()` possibly trying to convey?
>    I know naming is hard, but... `perhaps_suffix()`? Really?

The function is named thus since before 2000, when Cygwin was imported
into the public CVS repo ;)


Corinna
