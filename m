Return-Path: <cygwin-patches-return-3963-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4642 invoked by alias); 14 Jun 2003 12:34:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4629 invoked from network); 14 Jun 2003 12:34:01 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: <cygwin-patches@cygwin.com>
References: <BAY1-DAV43h4VGXTnKP000049e0@hotmail.com> <20030524180206.GD5604@redhat.com>
Subject: Re: Console title
Date: Sat, 14 Jun 2003 12:34:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY1-DAV19ll7o7DgiB0001929f@hotmail.com>
X-OriginalArrivalTime: 14 Jun 2003 12:34:00.0801 (UTC) FILETIME=[3B88A510:01C33271]
X-SW-Source: 2003-q2/txt/msg00190.txt.bz2

Hi,

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

When a program (screen) erases the current title, the old one is back.
Otherwise it's empty, which is ugly in my opinion.

Micha.
