Return-Path: <cygwin-patches-return-1505-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 25314 invoked by alias); 17 Nov 2001 20:19:24 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 25238 invoked from network); 17 Nov 2001 20:19:21 -0000
Date: Sun, 14 Oct 2001 07:21:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Don't modify const string in conv_path_list()
Message-ID: <20011117201925.GB29148@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20011117195929.7886D1BF249@duffek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011117195929.7886D1BF249@duffek.com>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2001-q4/txt/msg00037.txt.bz2

On Sat, Nov 17, 2001 at 02:59:29PM -0500, Nick Duffek wrote:
>Hi,
>
>On 15-Oct-2001, Robert Bogomip <bob.bogo@milohedge.com> wrote:
>
>>  bash-2.05$ (exec -c sh -c 'export PATH; ls')
>>        0 [main] sh 8724 open_stackdumpfile: Dumping stack trace to sh.exe.stackdump
>
>Here's a patch to fix that.
>
>Starting ash as above causes PATH to be a read-only compile-time string.
>When forking a subprocess, that string:
>  1. gets passed to execve() as part of the environment;
>  2. subsequently gets passed as a const char * parameter to
>     conv_path_list() in winsup/cygwin/path.cc;
>  3. becomes the target of an assignment in conv_path_list(), resulting in
>     the segmentation violation.
>
>The appended patch fixes the bug by copying PATH components instead of
>modifying PATH itself.
>
>winsup/cygwin/ChangeLog:
>
>	* path.cc (conv_path_list): Copy source paths before modifying
>	them.

Applied.

Thanks!

cgf
