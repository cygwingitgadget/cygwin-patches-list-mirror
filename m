Return-Path: <cygwin-patches-return-3894-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3748 invoked by alias); 25 May 2003 12:25:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3738 invoked from network); 25 May 2003 12:25:38 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: <cygwin-patches@cygwin.com>
References: <BAY1-DAV43h4VGXTnKP000049e0@hotmail.com> <20030524180206.GD5604@redhat.com>
Subject: Re: Console title
Date: Sun, 25 May 2003 12:25:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY1-DAV60xOjIL2jpW000192e2@hotmail.com>
X-OriginalArrivalTime: 25 May 2003 12:25:37.0335 (UTC) FILETIME=[BF2ED470:01C322B8]
X-SW-Source: 2003-q2/txt/msg00121.txt.bz2

Christopher Faylor wrote:
> On Sat, May 24, 2003 at 03:43:46PM +0200, Micha Nelissen wrote:
>>
>> This makes the set title go after the current title, instead of
>> replacing it. You need to enable hardstatus support in termcap to be
>> able to notice the difference. In particular the entries 'hs', 'fs',
>> 'ts' and 'ds' are needed. See 'man screen'.
>
> You have offered no justification for this change.  Obviously we
> could have appended the title after the existing title if we wanted
> to.
>
> What's the rationale here?

Ah, right, sorry.. If the title is removed by screen ('ds' termcap entry),
then the console title is empty. I want the old one to reappear. Placing the
title after the current one is one way of achieving that.

Micha.
