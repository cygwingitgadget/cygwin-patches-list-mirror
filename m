Return-Path: <cygwin-patches-return-3510-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17565 invoked by alias); 5 Feb 2003 17:34:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17553 invoked from network); 5 Feb 2003 17:34:31 -0000
Message-Id: <3.0.5.32.20030205123403.007e8a80@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Wed, 05 Feb 2003 17:34:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: ntsec odds and ends (cygcheck augmentation?)
In-Reply-To: <20030205165231.GY5822@cygbert.vinschen.de>
References: <20030205164834.GE15400@redhat.com>
 <3.0.5.32.20030205114159.00800620@mail.attbi.com>
 <20030205164834.GE15400@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q1/txt/msg00159.txt.bz2

At 05:52 PM 2/5/2003 +0100, Corinna Vinschen wrote:
>
>Actually I would prefer that over this extra check, changing the
>group name to "use mkpasswd".

I had some hesitations too. For a while I considered changing the
user name itself, but that would cause side effects.
Changing the group name doesn't matter at all. It used to be set
to "unknown", which provides no useful information.

I would like to provide unmistakable feedback, before the user
has a chance to write to the list and be told to run cygcheck.

Pierre
