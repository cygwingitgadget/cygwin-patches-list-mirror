Return-Path: <cygwin-patches-return-4369-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4329 invoked by alias); 14 Nov 2003 10:27:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4316 invoked from network); 14 Nov 2003 10:27:00 -0000
Message-ID: <3FB4AE07.6010101@cygwin.com>
Date: Fri, 14 Nov 2003 10:27:00 -0000
From: Robert Collins <rbcollins@cygwin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: thunk createDirectory and createFile calls
References: <3FB4A341.5070101@cygwin.com> <20031114101815.GU18706@cygbert.vinschen.de>
In-Reply-To: <20031114101815.GU18706@cygbert.vinschen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00088.txt.bz2

Corinna Vinschen wrote:

> On Fri, Nov 14, 2003 at 08:41:21PM +1100, Robert Collins wrote:
> 
>>inline 
>>BOOL cygwin_create_directory (LPCTSTR filename, LPSECURITY_ATTRIBUTES sec_attr)
>>{
>>  return CreateDirectory(filename, sec_attr);
> 
>            ^^^^^^^^^^^^^^^
> 	   CreateDirectoryA?

Ah, yeh.

Rob
