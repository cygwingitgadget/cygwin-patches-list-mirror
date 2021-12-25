Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 09A733858C27
 for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2021 17:10:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 09A733858C27
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (ae233132.dynamic.ppp.asahi-net.or.jp
 [14.3.233.132]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 1BPHA5gF022591;
 Sun, 26 Dec 2021 02:10:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 1BPHA5gF022591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1640452205;
 bh=0YRdNTyZvna0GsoR8T1qsf9xtAXeABXhe4H+motRWBQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=uFPGqss6PN+yYjPnj5pnEo1ociGJmtDj/uXfG0Jwbo/DdOk0rfZyQG7YOuMoYDXOL
 Y1KAvj7zPrr6lmJnwUUMrkX7suwJykkW00SAxtodJd857Cfhw0K/VKxneo/HrEHxO2
 rXltzn7HnOm/TQPsvzArmT9s7qUJjaLMaYFM4PoHkTAWnJLlh6d6OnB+Ty7+b7EJN8
 mhAGhSYbiWcVnXvptQTtxXcYQbTVdwHCFYSQRUWqHIlMDuQNs0A2gEuxNUhziFNMJh
 /WPoVxuwVuIO28BOBP2RhSiqfQsKog4soRguU3D+axs3NJGx8HMBMzwHh6e9meuw08
 RqXo2lN18+03A==
X-Nifty-SrcIP: [14.3.233.132]
Date: Sun, 26 Dec 2021 02:10:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_pipe: add sanity limit to handle loops
Message-Id: <20211226021010.a2b2ad28f12df9ffb25b6584@nifty.ne.jp>
In-Reply-To: <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
References: <alpine.BSO.2.21.2112231503400.11760@resin.csoft.net>
 <f97bba17-16ab-d7be-01f6-1c057fb5f1a5@cornell.edu>
 <alpine.BSO.2.21.2112231623490.11760@resin.csoft.net>
 <c5115e9b-6475-d30e-04d3-cb84cfa92b3a@cornell.edu>
 <alpine.BSO.2.21.2112241136160.11760@resin.csoft.net>
 <622d3ac6-fa5d-965c-52da-db7a4463fffd@cornell.edu>
 <alpine.BSO.2.21.2112241638280.11760@resin.csoft.net>
 <20211225121902.54b82f1bb0d4f958d34a8bb7@nifty.ne.jp>
 <alpine.BSO.2.21.2112241945060.11760@resin.csoft.net>
 <20211225131242.adef568db53d561a6b134612@nifty.ne.jp>
 <alpine.BSO.2.21.2112242101520.11760@resin.csoft.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 25 Dec 2021 17:10:40 -0000

On Fri, 24 Dec 2021 21:40:24 -0800 (PST)
Jeremy Drake wrote:
> On Sat, 25 Dec 2021, Takashi Yano wrote:
> 
> > On Fri, 24 Dec 2021 19:47:46 -0800 (PST)
> > Jeremy Drake wrote:
> > > phi->NumberOfHandles = 7999168, n_handle = 256
> > > assertion "phi->NumberOfHandles <= n_handle" failed: file
> > > "../../.././winsup/cygwin/fhandler_pipe.cc", line 1280, function: void*
> > > fhandler_pipe::get_query_hdl_per_process(WCHAR*, OBJECT_NAME_INFORMATION*)
> > > Aborted
> >
> > What!? Could you please check value of the "status" ?
> 
> status = 0x00000000, phi->NumberOfHandles = 7286688, n_handle = 256
> assertion "phi->NumberOfHandles <= n_handle" failed: file
> "../../.././winsup/cygwin/fhandler_pipe.cc", line 1281, function: void*
> fhandler_pipe::get_query_hdl_per_process(WCHAR*, OBJECT_NAME_INFORMATION*)
> Aborted
> 
> > What version of windows do you use?
> 
> This was on Windows 11 (22000.376) on ARM64, but msys2 has started seeing
> similar hangs on Github's "windows-2022" runner.  I don't have one of
> those locally to test against however.  But if push came to shove, I think
> I downloaded a Server 2022 evaluation ISO, I could set up a VM and see
> what happens.

Could you please check the result of the following test case
in that ARM64 platform?

The following code can be compiled using mingw compiper with
-lntdll flag.

#include <windows.h>
#include <ntdef.h>
#include <ntstatus.h>
#include <stdlib.h>
#include <stdio.h>

typedef enum
{
  ProcessHandleInformation = 51 /* Since Win8 */
} PROCESSINFOCLASS;

typedef struct
{
  HANDLE HandleValue;
  ULONG_PTR HandleCount;
  ULONG_PTR PointerCount;
  ULONG GrantedAccess;
  ULONG ObjectTypeIndex;
  ULONG HandleAttributes;
  ULONG Reserved;
} PROCESS_HANDLE_TABLE_ENTRY_INFO, *PPROCESS_HANDLE_TABLE_ENTRY_INFO;

typedef struct
{
  ULONG_PTR NumberOfHandles;
  ULONG_PTR Reserved;
  PROCESS_HANDLE_TABLE_ENTRY_INFO Handles[1];
} PROCESS_HANDLE_SNAPSHOT_INFORMATION;


NTSTATUS NTAPI NtQueryInformationProcess (HANDLE, PROCESSINFOCLASS,
  PVOID, ULONG, PULONG);

typedef enum
{
  SystemHandleInformation = 16
} SYSTEM_INFORMATION_CLASS;

typedef struct
{
  USHORT UniqueProcessId;
  USHORT CreatorBackTraceIndex;
  UCHAR ObjectTypeIndex;
  UCHAR HandleAttributes;
  USHORT HandleValue;
  PVOID Object;
  ULONG GrantedAccess;
} SYSTEM_HANDLE_TABLE_ENTRY_INFO;

typedef struct
{
  ULONG NumberOfHandles;
  SYSTEM_HANDLE_TABLE_ENTRY_INFO Handles[1];
} SYSTEM_HANDLE_INFORMATION;

NTSTATUS NTAPI NtQuerySystemInformation (SYSTEM_INFORMATION_CLASS,
  PVOID, ULONG, PULONG);

int main()
{
	NTSTATUS status;
	DWORD n_handle = 1;
	PROCESS_HANDLE_SNAPSHOT_INFORMATION *phi;
	do {
		DWORD nbytes = 2 * sizeof(ULONG_PTR)
			+ n_handle * sizeof(PROCESS_HANDLE_TABLE_ENTRY_INFO);
		phi = (PROCESS_HANDLE_SNAPSHOT_INFORMATION *)
			HeapAlloc(GetProcessHeap(), 0, nbytes);
		if (!phi) {
			fprintf(stderr, "HeapAlloc() Error: %08x\n", GetLastError());
			exit(1);
		}
		ULONG len;
		status = NtQueryInformationProcess(GetCurrentProcess(),
			ProcessHandleInformation, phi, nbytes, &len);
		if (NT_SUCCESS (status)) break;
		HeapFree(GetProcessHeap(), 0, phi);
		n_handle ++;
	} while (status == STATUS_INFO_LENGTH_MISMATCH);

	if (!NT_SUCCESS (status)) {
		fprintf(stderr, "NtQueryInformationProcess() error: %08x\n", status);
		HeapFree(GetProcessHeap(), 0, phi);
		exit(1);
	}

	printf("per_process: n_handle=%d, NumberOfHandles=%d\n",
		n_handle, phi->NumberOfHandles);
	if (phi->NumberOfHandles > n_handle) {
		HeapFree(GetProcessHeap(), 0, phi);
		exit(1);
	}
	HeapFree(GetProcessHeap(), 0, phi);


	n_handle = 1;
	SYSTEM_HANDLE_INFORMATION *shi;
	do {
		SIZE_T nbytes = sizeof(ULONG)
			+ n_handle * sizeof(SYSTEM_HANDLE_TABLE_ENTRY_INFO);
		shi = (SYSTEM_HANDLE_INFORMATION *) HeapAlloc (GetProcessHeap(),
			0, nbytes);
		if (!shi) {
			fprintf(stderr, "HeapAlloc() Error: %08x\n", GetLastError());
			exit(1);
		}
		status = NtQuerySystemInformation(SystemHandleInformation,
			shi, nbytes, NULL);
		if (NT_SUCCESS(status)) break;
		HeapFree (GetProcessHeap(), 0, shi);
		n_handle *= 2;
	} while (status == STATUS_INFO_LENGTH_MISMATCH);
	
	if (!NT_SUCCESS (status)) {
		fprintf(stderr, "NtQuerySystemInformation() error: %08x\n", status);
		HeapFree(GetProcessHeap(), 0, shi);
		exit(1);
	}

	printf("per_system: n_handle=%d, NumberOfHandles=%d\n",
		n_handle, shi->NumberOfHandles);
	if (shi->NumberOfHandles > n_handle) {
		HeapFree(GetProcessHeap(), 0, shi);
		exit(1);
	}
	HeapFree(GetProcessHeap(), 0, shi);

	return 0;
}

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
