Return-Path: <cygwin-patches-return-1468-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 24594 invoked by alias); 11 Nov 2001 22:47:21 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 24580 invoked from network); 11 Nov 2001 22:47:20 -0000
Message-ID: <040301c16b03$0d077130$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <bkeener@thesoftwaresource.com>,
	"cygwin-patches" <cygwin-patches@cygwin.com>
References: <VA.000009be.0055f8df@thesoftwaresource.com> <02a401c1691d$0b247030$0200a8c0@lifelesswks> <VA.000009c6.0059ec68@thesoftwaresource.com>
Subject: Re: [Patch] setup.exe - change Prev, Curr, Test Radio Buttons to a Single PushButton
Date: Mon, 01 Oct 2001 04:36:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 11 Nov 2001 22:54:50.0358 (UTC) FILETIME=[DE68F960:01C16B03]
X-SW-Source: 2001-q4/txt/msg00000.txt.bz2


----- Original Message -----
From: "Brian Keener" <bkeener@thesoftwaresource.com>
>
> The ultimate goal was to have the ability to hit a push button that
would cycle
> through "Curr", "Prev", "Test" versions as well as options for
> "Keep/Skip","Uninstall","Redownload","Reinstall" and "Sources" and
have it
> apply to the whole list of packages and not have to do them
individually.
> Unfortunately, with all the new changes that occurred in setup with
the
> categories and dependencies my understanding of all the trust logic
took a
> nosedive and any code I was working on/understood in this area
crumbled.

Yeah, the categories and dependencies made big changes to the internal
logic - as you'd expect. I'm hoping to fiddle this in the near future
and make it a little easier to hack on.

Rob
