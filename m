Return-Path: <cygwin-patches-return-4380-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5128 invoked by alias); 14 Nov 2003 15:52:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5102 invoked from network); 14 Nov 2003 15:52:15 -0000
Date: Fri, 14 Nov 2003 15:52:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: thunk createDirectory and createFile calls
Message-ID: <20031114155212.GC15938@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4A341.5070101@cygwin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB4A341.5070101@cygwin.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00099.txt.bz2

On Fri, Nov 14, 2003 at 08:41:21PM +1100, Robert Collins wrote:
>        Rename CreateFile to cygwin_create_file throughout.
                              ^^^^^^^^^^^^^^^^^^
>        Rename CreateDirectory to cygwin_create_directory throughout.
                                   ^^^^^^^^^^^^^^^^^^^^^^^

It is a given that we're working in cygwin.  Adding a cygwin_ to the
beginning of a function is just noise.

cgf
