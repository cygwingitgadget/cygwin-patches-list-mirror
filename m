Return-Path: <cygwin-patches-return-4104-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3611 invoked by alias); 17 Aug 2003 18:02:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3599 invoked from network); 17 Aug 2003 18:02:52 -0000
Date: Sun, 17 Aug 2003 18:02:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pwdgrp::read_group(): Don't call free() twice with the same address
Message-ID: <20030817180251.GB5907@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030817105058.007e9b40@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030817105058.007e9b40@mail.attbi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00120.txt.bz2

On Sun, Aug 17, 2003 at 10:50:58AM -0400, Pierre A. Humblet wrote:
>While Dave Rothenberger has correctly localized the problem
>described in
><http://www.cygwin.com/ml/cygwin/2003-08/msg00364.html>
>the patch 
><http://cygwin.com/ml/cygwin-patches/2003-q3/msg00062.html>
>only fixes the symptom of the bug but not the root cause.
>
>Setting gr_mem to &null_ptr below should not be necessary
>because the subsequent load() should reset curr_lines to 0
>and call pwdgrp::parse_group (), which sets gr_mem to &null_ptr.
>Thus free() should never be called twice. 
>******
>  for (int i = 0; i < gr.curr_lines; i++)
>    if ((*group_buf)[i].gr_mem != &null_ptr)
>      {
>        free ((*group_buf)[i].gr_mem);
>        (*group_buf)[i].gr_mem = &null_ptr;
>      }
>
>  load ("/etc/group");
>******
>
>The original bug report mentions that the problem only occurs 
>when /etc is absent. In that case curr_lines is NOT reset by 
>pwdgrp::load, although it is incremented when the default entries
>(the ones with "mkpasswd" and "????????") are added to the internal 
>group file. 
>When /etc does not exist, the default entries are added repeatedly 
>and the internal group file keeps growing (ditto for passwd).
>
>I believe that reverting the original patch and applying the one 
>below fixes the root bug.

You're absolutely right.  Please check in.

cgf
