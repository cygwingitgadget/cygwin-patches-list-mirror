Return-Path: <cygwin-patches-return-2513-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 899 invoked by alias); 25 Jun 2002 11:52:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 858 invoked from network); 25 Jun 2002 11:52:55 -0000
Message-ID: <3D185911.CB269110@yahoo.com>
Date: Tue, 25 Jun 2002 05:46:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To: Earnie Boyd <Cygwin-Patches@Cygwin.Com>
X-Accept-Language: en
MIME-Version: 1.0
To: Conrad Scott <Conrad.Scott@dsl.pipex.com>
CC: cygwin-patches@cygwin.com
Subject: Re: Add FILE_FLAG_FIRST_PIPE_INSTANCE to <w32api/winbase.h>
References: <20020622150321.13099.qmail@web20708.mail.yahoo.com> <04a101c219ff$81bedf80$6132bc3e@BABEL>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q2/txt/msg00496.txt.bz2

Yes, you may commit the change except make the ChangeLog entry

        * include/winbase.h (FILE_FLAG_FIRST_PIPE_INSTANCE): Add
constant.

Earnie.

Conrad Scott wrote:
> 
> Earnie,
> 
> Thanks for the reply about the WINVER setting. I've attached a new
> version of the patch with a guard of _WIN32_WINNT >= 0x0500, as you
> suggested.
> 
> I hope this is better.
> 
> // Conrad
> 
>   ------------------------------------------------------------------------
>                     Name: ChangeLog.txt
>    ChangeLog.txt    Type: Plain Text (text/plain)
>                 Encoding: 7bit
> 
>                    Name: w32api.patch
>    w32api.patch    Type: unspecified type (application/octet-stream)
>                Encoding: quoted-printable
