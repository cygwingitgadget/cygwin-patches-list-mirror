Return-Path: <cygwin-patches-return-5014-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31814 invoked by alias); 5 Oct 2004 14:34:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31524 invoked from network); 5 Oct 2004 14:34:38 -0000
Date: Tue, 05 Oct 2004 14:34:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] cygcheck: warn about empty path-components
Message-ID: <20041005143458.GB13719@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <n2m-g.cjth8v.3vsj9uv.1@buzzy-box.bavag> <20041005081629.GI6702@cygbert.vinschen.de> <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0410050902580.5620@fordpc.vss.fsi.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00015.txt.bz2

On Tue, Oct 05, 2004 at 09:09:31AM -0500, Brian Ford wrote:
>On Tue, 5 Oct 2004, Corinna Vinschen wrote:
>
>> Chris, I might be missing something but that looks like a bug in
>> conv_path_list to me.  Why is conv_fn called with "." for empty
>> strings instead of ignoring the empty path?
>>
>> Is an empty path component a windowzism I don't know about?
>
>I don't know if it's part of any standard, but it's a *NIXism.  From
>Solaris 8 "man sh":
>
>Execution:
>
>The current directory is specified by a null path name, which can appear
>immediately after the equal sign, between two colon delimiters anywhere in
>the path list, or at the end of the path list.
>
>"man ksh"
>
>Execution:
>
>The default path is /bin:/usr/bin:  (specifying /bin, /usr/bin, and the
>current directory in that order).
>
>The current directory can be specified by two or more adjacent colons, or
>by a colon at the beginning or end of the path list.
>
>etc...
>
>I believe this is a valid construct and I have used it frequently.

Ditto.

PATH=/foo::/bar

means search for /foo, then the current directory, then /bar.

cgf
