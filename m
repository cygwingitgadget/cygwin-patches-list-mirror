Return-Path: <cygwin-patches-return-4368-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1765 invoked by alias); 14 Nov 2003 10:18:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1752 invoked from network); 14 Nov 2003 10:18:16 -0000
Date: Fri, 14 Nov 2003 10:18:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: thunk createDirectory and createFile calls
Message-ID: <20031114101815.GU18706@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4A341.5070101@cygwin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB4A341.5070101@cygwin.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00087.txt.bz2

On Fri, Nov 14, 2003 at 08:41:21PM +1100, Robert Collins wrote:
> /* io.h
> 
>    Copyright 2003 Robert Collins  <rbtcollins@hotmail.com>
>    Copyright 2003 Ron Parker      <rdparker@butlermfg.com>
> 
> This file is part of Cygwin.
> 
> This software is a copyrighted work licensed under the terms of the
> Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
> details. */
> 
> #ifndef _IO_H_
> #define _IO_H_
> 
> inline HANDLE
> cygwin_create_file (LPCTSTR file_name, DWORD access, DWORD share_mode,
> 				  LPSECURITY_ATTRIBUTES sec_attr,
> 				  DWORD disposition, DWORD flags,
> 				  HANDLE template_file)
> {
>   return CreateFileA(file_name, access, share_mode, sec_attr, disposition,
>       		     flags, template_file);
> }
> 
> inline 
> BOOL cygwin_create_directory (LPCTSTR filename, LPSECURITY_ATTRIBUTES sec_attr)
> {
>   return CreateDirectory(filename, sec_attr);
           ^^^^^^^^^^^^^^^
	   CreateDirectoryA?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
