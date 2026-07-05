{...}:
{
  services.ollama = {
    enable = true;
    # Uses the CUDA-accelerated package to offload to the MX330
    package = pkgs.ollama-cuda;

    # Optional: Declaratively pull models on startup
    loadModels = [
      "llama3.2:3b"
      "qwen2.5-coder:7b"
    ];
  };
}
