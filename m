Return-Path: <cygwin-patches-return-3536-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25183 invoked by alias); 6 Feb 2003 21:13:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25174 invoked from network); 6 Feb 2003 21:13:26 -0000
Message-ID: <3E42CFF2.7020905@yahoo.com>
Date: Thu, 06 Feb 2003 21:13:00 -0000
From: Earnie Boyd <earnie_boyd@yahoo.com>
Reply-To:  cygwin-patches@cygwin.com
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christopher Faylor <cgf@redhat.com>
CC:  cygwin-patches@cygwin.com
Subject: Re: [PATCH] w32api [jld@ecoscentric.com: PathRelativePathTo() declarations]
References: <20030206194917.GB26036@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q1/txt/msg00185.txt.bz2

2003-02-04  Danny Smith  <dannysmith@users.sourceforge.net>

	* include/shlwapi.h (PathRelativePathTo[AW]): Correct
	prototypes.
	Thanks to: John Dallaway  <jld@ecoscentric.com>.

Thanks,
Earnie.


Christopher Faylor wrote:
> Danny,
> I don't know if you read the cygwin mailing list but just in case...
> 
> cgf
> 
> ----- Forwarded message from John Dallaway <jld@ecoscentric.com> -----
> 
> From: John Dallaway <jld@ecoscentric.com>
> To: cygwin@cygwin.com
> Subject: PathRelativePathTo() declarations
> Date: Tue, 4 Feb 2003 09:32:39 +0000
> Mail-Followup-To: cygwin@cygwin.com
> Organization: eCosCentric Limited
> 
> I have discovered a trivial error in the shlwapi.h Win32 API header
> file. I'm not a Cygwin developer but have appended a patch to the
> installed file.
> 
> John Dallaway
> eCosCentric Limited
> 
> --cut here--
> 
> --- shlwapi.h.old       2002-11-25 20:21:02.000000000 +0000
> +++ shlwapi.h   2003-02-03 12:44:08.000000000 +0000
> @@ -262,12 +262,12 @@
>  WINSHLWAPI BOOL WINAPI PathMatchSpecW(LPCWSTR,LPCWSTR);
>  WINSHLWAPI int WINAPI PathParseIconLocationA(LPSTR);
>  WINSHLWAPI int WINAPI PathParseIconLocationW(LPWSTR);
>  WINSHLWAPI void WINAPI PathQuoteSpacesA(LPSTR);
>  WINSHLWAPI void WINAPI PathQuoteSpacesW(LPWSTR);
> -WINSHLWAPI BOOL WINAPI PathRelativePathToA(LPSTR,LPCSTR,DWORD,LPCWSTR,DWORD);
> -WINSHLWAPI BOOL WINAPI PathRelativePathToW(LPWSTR,LPCWSTR,DWORD,LPCSTR,DWORD);
> +WINSHLWAPI BOOL WINAPI PathRelativePathToA(LPSTR,LPCSTR,DWORD,LPCSTR,DWORD);
> +WINSHLWAPI BOOL WINAPI PathRelativePathToW(LPWSTR,LPCWSTR,DWORD,LPCWSTR,DWORD);
>  WINSHLWAPI void WINAPI PathRemoveArgsA(LPSTR);
>  WINSHLWAPI void WINAPI PathRemoveArgsW(LPWSTR);
>  WINSHLWAPI LPSTR WINAPI PathRemoveBackslashA(LPSTR);
>  WINSHLWAPI LPWSTR WINAPI PathRemoveBackslashW(LPWSTR);
>  WINSHLWAPI void WINAPI PathRemoveBlanksA(LPSTR);
> 
> 
> --
> Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
> Bug reporting:         http://cygwin.com/bugs.html
> Documentation:         http://cygwin.com/docs.html
> FAQ:                   http://cygwin.com/faq/
> 
> ----- End forwarded message -----
> 
