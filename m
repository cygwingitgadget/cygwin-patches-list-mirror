Return-Path: <cygwin-patches-return-4361-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22602 invoked by alias); 12 Nov 2003 16:08:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22585 invoked from network); 12 Nov 2003 16:08:42 -0000
Date: Wed, 12 Nov 2003 16:08:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: dtable.cc typo
Message-ID: <20031112160839.GB26524@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0311111612280.9584@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0311111612280.9584@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00080.txt.bz2

On Tue, Nov 11, 2003 at 06:08:08PM -0600, Brian Ford wrote:
>I don't know c++ much/at all, but this looks wrong to me.  I don't
>understand how it even compiled before?  Feel free to slap me in the face
>because you can switch on a struct in c++? :)
>
>2003-11-11  Brian Ford  <ford@vss.fsi.com>
>
>	* dtable.cc (build_fh_pc): Fix typo in device number switch.

Not a problem.

struct device
{
  .
  .
  .
  inline operator int () const {return devn;}
  .
  .
  .
}

cgf

>Index: dtable.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
>retrieving revision 1.119
>diff -u -p -r1.119 dtable.cc
>--- dtable.cc	1 Oct 2003 12:36:39 -0000	1.119
>+++ dtable.cc	11 Nov 2003 22:08:59 -0000
>@@ -340,7 +340,7 @@ build_fh_pc (path_conv& pc)
> 	fh = cnew (fhandler_dev_tape) ();
> 	break;
>       default:
>-	switch (pc.dev)
>+	switch (pc.dev.devn)
> 	  {
> 	  case FH_CONSOLE:
> 	  case FH_CONIN:
