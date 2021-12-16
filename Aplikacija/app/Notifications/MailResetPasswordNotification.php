<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

use Illuminate\Auth\Notifications\ResetPassword;
class MailResetPasswordNotification extends ResetPassword
{
    use Queueable;

    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct($token)
    {
        parent::__construct($token);
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function via($notifiable)
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    public function toMail($notifiable)
    {
        $link = url("/auth/reset-password/" . $this->token);
        return (new MailMessage)
            ->subject('Resetovanje lozinke')
            ->greeting("Pozdrav")
            ->line(" Primili ste ovaj mejl jer smo dobili zahtjev za resetovanje lozinke naloga koji je povezan sa ovim emailom.")
            ->action('Resetuj lozinku', $link)
            ->line("Ovaj link će isteći nakon " . config('auth.passwords.users.expire') . " minuta.")
            ->line("Ukoliko ste ovaj mail dobili greškom, ignorišite ga.")
            ->salutation("Srdačan pozdrav!");
            
    }

    /**
     * Get the array representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function toArray($notifiable)
    {
        return [
            //
        ];
    }
}
