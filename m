Return-Path: <cygwin-patches-return-1779-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10735 invoked by alias); 25 Jan 2002 01:51:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10714 invoked from network); 25 Jan 2002 01:51:29 -0000
Date: Thu, 24 Jan 2002 17:51:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]Package extention recognition
Message-ID: <20020125015129.GA16592@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <003f01c1a542$742968e0$a100a8c0@mchasecompaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003f01c1a542$742968e0$a100a8c0@mchasecompaq>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00136.txt.bz2

On Thu, Jan 24, 2002 at 05:48:35PM -0800, Michael A Chase wrote:
>I noticed that find_tar_ext() always returns after checking for ".tar.bz2"
>and ".tar.gz" so it never gets to the check for ".tar".  As long as I was
>fixing that, it seemed like a good time to add ".cwp" as an accepted file
>extension.

Haven't we already debated this issue?  I don't see any reason to inflict
a .cwp on the world and I can't imagine why we'd ever want a plain .tar
rather than a .tar.bz2.

cgf
