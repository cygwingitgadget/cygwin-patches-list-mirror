Return-Path: <cygwin-patches-return-3768-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12541 invoked by alias); 27 Mar 2003 18:38:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12532 invoked from network); 27 Mar 2003 18:38:04 -0000
Date: Thu, 27 Mar 2003 18:38:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] New '--install-type' option for cygcheck?
Message-ID: <20030327183835.GM12539@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <006701c2f432$c62a5380$fa6d86d9@ellixia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006701c2f432$c62a5380$fa6d86d9@ellixia>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00417.txt.bz2

On Thu, Mar 27, 2003 at 07:30:42AM -0000, Elfyn McBratney wrote:
>I've been working on a new option for `cygcheck' that checks who Cygwin was
>installed for. This could be used when users on the mailing list have
>problems running services when the installation was done for "Just Me",
>executing files in the same situation etc. Would this be a desirable
>feature? Yes/no...patch attached :-)

Doesn't cygcheck already report the appropriate registry keys from HKLM
and HKCU?  If not, I think that just reporting the keys from both of those
is all that we really need to do rather than adding a special option.

cgf
