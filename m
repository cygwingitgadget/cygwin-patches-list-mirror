Return-Path: <cygwin-patches-return-1488-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 20653 invoked by alias); 13 Nov 2001 23:49:03 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 20613 invoked from network); 13 Nov 2001 23:49:02 -0000
Message-ID: <01ee01c16c9e$0350bce0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <bkeener@thesoftwaresource.com>,
	"cygwin-patches" <cygwin-patches@cygwin.com>
References: <VA.000009d7.011e66c9@thesoftwaresource.com>
Subject: Re: [Patch] setup.exe - change to not ask root on download only.
Date: Wed, 10 Oct 2001 11:47:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 13 Nov 2001 23:56:27.0709 (UTC) FILETIME=[CF0776D0:01C16C9E]
X-SW-Source: 2001-q4/txt/msg00020.txt.bz2

Brian,
can you generate patches with "-up" ? (See the cygwin contributors
page).
It makes it a lot easier to visually grok a patch.

I'll update this for you to the io_streams code for HEAD committing.

Lastly, you were missing a call to get_root_dir_now which resulted in
/etc/setup/last-cache never getting read.

Thanks for this.

Rob
