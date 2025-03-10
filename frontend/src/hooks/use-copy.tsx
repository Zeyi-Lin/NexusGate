import { useCallback, useState } from 'react'
import { toast } from 'sonner'

export interface UseCopyOptions {
  timeout?: number
  showSuccessToast?: boolean
  successToastMessage?: string
  showErrorToast?: boolean
}

export interface UseCopyReturn {
  copy: (text: string) => Promise<boolean>
  copied: boolean
}

export function useCopy(opts: UseCopyOptions = {}): UseCopyReturn {
  const { timeout = 2000, successToastMessage = 'Copied!', showSuccessToast = false, showErrorToast = true } = opts

  const [copied, setCopied] = useState(false)

  const copy = useCallback(
    async (text: string) => {
      if (!navigator?.clipboard) {
        if (showErrorToast)
          toast.error('Clipboard not supported.', {
            description: (
              <div>
                <p>You can copy the text below manually.</p>
                <div className="bg-background mt-1 rounded border px-1.5 py-0.5 select-all">{text}</div>
              </div>
            ),
          })
        return false
      }

      return await navigator.clipboard
        .writeText(text)
        .then(() => {
          setCopied(true)
          if (showSuccessToast) toast.success(successToastMessage)
          setTimeout(() => setCopied(false), timeout)
          return true
        })
        .catch((err) => {
          if (showErrorToast) toast.error(`Failed to copy: ${err}`)
          return false
        })
    },
    [showErrorToast, showSuccessToast, successToastMessage, timeout],
  )

  return { copy, copied }
}
