Return-Path: <cygwin-patches-return-2495-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3036 invoked by alias); 23 Jun 2002 11:20:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2981 invoked from network); 23 Jun 2002 11:20:12 -0000
Message-ID: <002901c21aa7$eb2ab360$1800a8c0@LAPTOP>
From: "Robert Collins" <robert.collins@syncretize.net>
To: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
Cc: <cygwin-patches@cygwin.com>
References: <000601c21a8b$bd8324e0$0200a8c0@lifelesswks> <062501c21a99$47da4300$6132bc3e@BABEL>
Subject: Re: Resubmission of cygwin_daemon patch.
Date: Sun, 23 Jun 2002 07:01:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
X-SW-Source: 2002-q2/txt/msg00478.txt.bz2


----- Original Message -----
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: "Robert Collins" <robert.collins@syncretize.net>
Cc: <cygwin-patches@cygwin.com>
Sent: Sunday, June 23, 2002 7:35 PM

> About instance detection: you're right that something better could be
> done here. What I've ended up with is really a security patch: it's
> possible for another process to create an instance of a named pipe,
> wait for clients to connect and then impersonate them.

It will always be possible to do that. Anyone can build the cygserver and
insert hostile code into their build. Code interception is a standard
technique for reverse engineering, runtime patching and the like.

In terms of preventing someone hostilely opening the same socket/pipe, I'd
have thought windows prevented multiple listening pipes with the same name.

Rob
