Return-Path: <cygwin-patches-return-1674-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27406 invoked by alias); 12 Jan 2002 09:19:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27392 invoked from network); 12 Jan 2002 09:19:13 -0000
Message-ID: <032e01c19b4a$35230fe0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
References: <911C684A29ACD311921800508B7293BA037D29E6@cnmail> <20020112031851.GA5052@redhat.com>
Subject: Re: [PATCH] mkpasswd.c - allows selection of specific user
Date: Sat, 12 Jan 2002 01:19:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 12 Jan 2002 09:19:11.0914 (UTC) FILETIME=[326F88A0:01C19B4A]
X-SW-Source: 2002-q1/txt/msg00031.txt.bz2

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
> These are nice changes, but I have a few observations:

> 2) I don't think there is any reason to report the number if you
>    are translating the text, so, I'd prefer:
>
>    mkpasswd: The user name could not be found

My 2c: keep the number. Put it in brackets or something. It's a _lot_
easier for sysadmins.

Rob
