Return-Path: <cygwin-patches-return-3660-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29555 invoked by alias); 1 Mar 2003 16:40:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29546 invoked from network); 1 Mar 2003 16:40:26 -0000
Message-Id: <3.0.5.32.20030301113624.00800dd0@mail.attbi.com>
X-Sender: phumblet@mail.attbi.com (Unverified)
Date: Sat, 01 Mar 2003 16:40:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: mkpasswd & mkgroup 
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00309.txt.bz2

On Tue, 25 Feb 2003 12:58:47 +0100 Corinna Vinschen wrote:

>> Also, to support arbitrary uid's on Win95, mkpasswd prints both
>> a default line with uid 500, and a line for the current user 
>> with a pseudorandom uid. Other users can be added with -u.
>> Cygwin uses the default line for users that do not have an entry.

> That's fine.  Regardless of the above, we could apply this one.
> Feel free to commit that change.

Done.

Pierre
